extends Control


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)


func _on_show_audio_toggled(toggled_on: bool) -> void:
	Game.show_audio_toggled(toggled_on)


func _on_delete_on_touch_toggled(toggled_on: bool) -> void:
	Game.delete_on_touch = toggled_on


func _on_enable_physics_toggled(toggled_on: bool) -> void:
	Game.physics_toggled(toggled_on)


func _on_clear_button_pressed() -> void:
	Game.clear_pressed()


func _on_save_button_pressed() -> void:
	Game.save_pressed()


func _on_quit_button_pressed() -> void:
	Game.quit_pressed()


func _on_visibility_changed() -> void:
	%EnablePhysics.visible = Game.has_global_mesh
	%SaveButton.disabled = not Game.can_save
