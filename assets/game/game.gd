extends Node


signal save

signal quit

signal show_audio(p_visible : bool)

signal create_decoration(p_decoration : DecorationType)


# Delete on touch flag
var delete_on_touch : bool = false


func save_pressed() -> void:
	save.emit()


func quit_pressed() -> void:
	quit.emit()


func show_audio_toggled(p_visible : bool) -> void:
	show_audio.emit(p_visible)


func create_decoration_selected(p_decoration : DecorationType) -> void:
	create_decoration.emit(p_decoration)
