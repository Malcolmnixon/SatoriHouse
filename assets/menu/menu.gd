extends Control


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)


func _on_show_audio_toggled(toggled_on: bool) -> void:
	Game.show_audio_toggled(toggled_on)


func _on_delete_on_touch_toggled(toggled_on: bool) -> void:
	Game.delete_on_touch = toggled_on


func _on_capture_scene_pressed() -> void:
	Game.capture_scene_pressed()


func _on_enable_physics_toggled(toggled_on: bool) -> void:
	Game.physics_toggled(toggled_on)


func _on_enable_shadows_toggled(toggled_on: bool) -> void:
	Game.shadows_toggled(toggled_on)


func _on_clear_button_pressed() -> void:
	Game.clear_pressed()


func _on_save_button_pressed() -> void:
	Game.save_pressed()


func _on_quit_button_pressed() -> void:
	Game.quit_pressed()


func _on_visibility_changed() -> void:
	%CaptureScene.visible = Game.can_scene_capture
	%EnablePhysics.visible = Game.has_scene_anchors
	%SaveButton.disabled = not Game.can_save
