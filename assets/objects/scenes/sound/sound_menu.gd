extends Node3D


@export var player : AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu := %Menu.get_scene_instance() as SoundMenu2D
	menu.set_player(player)
