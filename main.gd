extends Node3D


const SAVE_FILE := "user://room.json"
const SOUND_RENDER_LAYER := 0x80000
const SOUND_PHYSICS_LAYER := 0x80000000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.save.connect(_save)
	Game.quit.connect(_quit)
	Game.show_audio.connect(_on_show_audio)
	Game.capture_scene.connect(_on_capture_scene)
	Game.create_decoration.connect(_on_create_decoration)
	Game.shadows_changed.connect(_on_shadows_changed)

	# Test if scene manager is real
	if %SceneManager.is_class("OpenXRFbSceneManager"):
		%SceneManager.openxr_fb_scene_data_missing.connect(_scene_data_missing)
		%SceneManager.openxr_fb_scene_capture_completed.connect(_scene_capture_completed)
		Game.can_scene_capture = true

	# Test if the anchor manager is real
	if %AnchorManager.is_class("OpenXRFbSpatialAnchorManager"):
		Game.can_save = true
		_load()


func _on_show_audio(p_visible : bool) -> void:
	if p_visible:
		%XRCamera3D.cull_mask |= SOUND_RENDER_LAYER
		%LeftFingerPoke.mask |= SOUND_PHYSICS_LAYER
		%RightFingerPoke.mask |= SOUND_PHYSICS_LAYER
	else:
		%XRCamera3D.cull_mask &= ~SOUND_RENDER_LAYER
		%LeftFingerPoke.mask &= ~SOUND_PHYSICS_LAYER
		%RightFingerPoke.mask &= ~SOUND_PHYSICS_LAYER


func _on_create_decoration(p_decoration : DecorationType) -> void:
	# Get the creation position
	var pos : Vector3 = %XRCamera3D.to_global(Vector3(0, -0.2, -0.8))

	# Create the instance
	var packed_scene : PackedScene = load(p_decoration.instance_scene)
	var instance : Node3D = packed_scene.instantiate()

	# Add to the scene
	%Decorations.add_child(instance)
	instance.global_position = pos


func _on_shadows_changed() -> void:
	%DirectionalLight3D.shadow_enabled = Game.shadows_enabled


func _load() -> void:
	# Open the file
	var file := FileAccess.open(SAVE_FILE, FileAccess.READ)
	if not file:
		return

	# Parse the file
	var json := JSON.new()
	if json.parse(file.get_as_text()) != OK:
		return

	# Verify we have a dictionary
	if json.data is not Dictionary:
		return

	# Process the data
	var anchor_data : Dictionary = json.data
	if anchor_data.size() == 0:
		return

	# Load the anchors
	%AnchorManager.load_anchors(anchor_data.keys(), anchor_data)

	# Wait for all decorations anchors to be created
	while %AnchorManager.get_anchor_uuids().size() < anchor_data.size():
		await get_tree().create_timer(0.1).timeout

	# Construct the decorations
	for uuid in anchor_data:
		var entity = %AnchorManager.get_spatial_entity(uuid)
		if not entity:
			continue

		var anchor : XRAnchor3D = %AnchorManager.get_anchor_node(uuid)
		if not anchor:
			continue

		var custom_data : Dictionary = entity.custom_data
		var instance_scene : String = custom_data["scene"]

		# Create the instance
		var packed_scene : PackedScene = load(instance_scene)
		var instance : Node3D = packed_scene.instantiate()

		# Add to the scene
		%Decorations.add_child(instance)
		instance.global_transform = anchor.global_transform


func _save() -> void:
	# Clear all UUIDs
	for uuid in %AnchorManager.get_anchor_uuids():
		%AnchorManager.untrack_anchor(uuid)

	# Create anchors for all decorations
	var decorations := 0
	for node in %Decorations.get_children():
		var decoration := node as Decoration
		if not decoration:
			continue

		# Create an anchor for the decoration
		var custom_data := { "scene" : decoration.type.instance_scene }
		%AnchorManager.create_anchor(decoration.global_transform, custom_data)
		decorations += 1

	# Wait for all decorations anchors to be created
	while %AnchorManager.get_anchor_uuids().size() < decorations:
		await get_tree().create_timer(0.1).timeout

	# Populate the anchor data to save
	var anchor_data := {}
	for uuid in %AnchorManager.get_anchor_uuids():
		var entity = %AnchorManager.get_spatial_entity(uuid)
		anchor_data[uuid] = entity.custom_data

	# Save the anchor file
	var file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(anchor_data))
		file.close()


func _on_capture_scene() -> void:
	%SceneManager.request_scene_capture()


func _scene_data_missing() -> void:
	%SceneManager.request_scene_capture()


func _scene_capture_completed(p_success : bool) -> void:
	# Skip on capture failure
	if not p_success:
		return

	# Remove old anchors
	if %SceneManager.are_scene_anchors_created():
		%SceneManager.remove_scene_anchors()

	# Create anchors
	%SceneManager.create_scene_anchors()


func _quit() -> void:
	%StartXR.end_xr()
