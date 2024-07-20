extends Node


signal show_audio(p_visible : bool)

signal capture_scene

signal physics_changed

signal create_decoration(p_decoration : DecorationType)

signal clear

signal save

signal quit



## Test if scene capture is supported
var can_scene_capture : bool = false

## Test if scene anchors are present
var has_scene_anchors : bool = false

## Should objects be deleted on touch
var delete_on_touch : bool = false

## Is physics enabled
var physics_enabled : bool = false

## Is save supported
var can_save : bool = false


func show_audio_toggled(p_visible : bool) -> void:
	show_audio.emit(p_visible)


func create_decoration_selected(p_decoration : DecorationType) -> void:
	create_decoration.emit(p_decoration)


func capture_scene_pressed() -> void:
	capture_scene.emit()


func physics_toggled(p_physics_enabled : bool) -> void:
	physics_enabled = p_physics_enabled
	physics_changed.emit()


func clear_pressed() -> void:
	clear.emit()


func save_pressed() -> void:
	save.emit()


func quit_pressed() -> void:
	quit.emit()
