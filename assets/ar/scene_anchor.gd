extends StaticBody3D


@export var material : Material


func setup_scene(entity : OpenXRFbSpatialEntity) -> void:
	# Construct the collison shape
	var collision_shape := entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)
		Game.has_scene_anchors = true

	# Construct the collision mesh
	var mesh_instance := entity.create_mesh_instance()
	if mesh_instance:
		add_child(mesh_instance)
		mesh_instance.material_override = material
