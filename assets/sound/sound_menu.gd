extends Control


@export var player : AudioStreamPlayer3D


func _on_volume_value_changed(value: float) -> void:
	player.volume_db = linear_to_db(value)


func _on_range_value_changed(value: float) -> void:
	player.unit_size = value
	player.max_distance = value * 10
