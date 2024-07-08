extends Node


signal show_audio(p_visible : bool)


func save() -> void:
	pass


func quit() -> void:
	get_tree().quit()


func show_audio_toggled(p_visible : bool) -> void:
	show_audio.emit(p_visible)
