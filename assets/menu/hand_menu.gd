extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var controller := get_parent() as XRController3D
	if controller:
		controller.button_pressed.connect(_on_button_pressed)
		controller.button_released.connect(_on_button_released)


func _on_button_pressed(p_button : String) -> void:
	if p_button == "hand_menu":
		$Menu.enabled = true
		$Menu.visible = true
	
func _on_button_released(p_button : String) -> void:
	if p_button == "hand_menu":
		$Menu.enabled = false
		$Menu.visible = false
