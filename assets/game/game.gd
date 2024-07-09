extends Node


signal show_audio(p_visible : bool)

signal create_decoration(p_decoration : Decoration)


# Delete on touch flag
var delete_on_touch : bool = false


func save() -> void:
	pass


func quit() -> void:
	get_tree().quit()


func show_audio_toggled(p_visible : bool) -> void:
	show_audio.emit(p_visible)


func create_decoration_selected(p_decoration : Decoration) -> void:
	create_decoration.emit(p_decoration)
