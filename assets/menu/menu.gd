extends Control


func _on_save_button_pressed() -> void:
	Game.save()


func _on_quit_button_pressed() -> void:
	Game.quit()


func _on_show_audio_toggled(toggled_on: bool) -> void:
	Game.show_audio_toggled(toggled_on)
