extends Control


func _on_save_button_pressed() -> void:
	Game.save_pressed()


func _on_quit_button_pressed() -> void:
	Game.quit_pressed()


func _on_show_audio_toggled(toggled_on: bool) -> void:
	Game.show_audio_toggled(toggled_on)


func _on_delete_on_touch_toggled(toggled_on: bool) -> void:
	Game.delete_on_touch = toggled_on
