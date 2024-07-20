extends Node3D


## Camera for view-checking
@export var camera : XRCamera3D

## Angle for view-checking
@export_range(0, 90, 0.1, "radians") var max_angle := 0.785398


## Controller
@onready var controller : XRController3D = get_parent()

## Menu
@onready var menu : XRToolsViewport2DIn3D = $Menu


func _process(_delta : float) -> void:
	# Inspect the view angle
	var camera_xform := camera.global_transform
	var menu_xform := menu.global_transform
	var to_camera = (camera_xform.origin - menu_xform.origin).normalized()
	var angle := menu_xform.basis.z.angle_to(to_camera)

	# Decide whether the menu should be shown
	var show := controller.is_button_pressed("hand_menu") and angle <= max_angle

	# Toggle visibility
	if show and not menu.visible:
		menu.enabled = true
		menu.visible = true
	elif not show and menu.visible:
		menu.enabled = false
		menu.visible = false
