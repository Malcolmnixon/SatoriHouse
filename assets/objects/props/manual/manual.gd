extends Decoration


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$Viewport2Din3D.connect_scene_signal("close_pressed", _on_close_pressed)


func _on_close_pressed() -> void:
	queue_free()
