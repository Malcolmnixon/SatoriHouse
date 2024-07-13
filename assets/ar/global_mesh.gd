extends StaticBody3D


func setup_scene(entity : OpenXRFbSpatialEntity) -> void:
	# Construct the collison shape
	var collision_shape := entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)
		Game.has_global_mesh = true
