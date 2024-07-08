extends Node3D


@export var stream : AudioStream


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%AudioStreamPlayer3D.stream = stream
	%AudioStreamPlayer3D.play()
