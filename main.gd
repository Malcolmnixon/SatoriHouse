extends Node3D


const SOUND_RENDER_LAYER := 0x80000
const SOUND_PHYSICS_LAYER := 0x80000000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.save.connect(_save)
	Game.quit.connect(_quit)
	Game.show_audio.connect(_on_show_audio)
	Game.create_decoration.connect(_on_create_decoration)


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


func _save() -> void:
	# TODO: Add Spatial Anchors Support
	pass


func _quit() -> void:
	%StartXR.end_xr()
