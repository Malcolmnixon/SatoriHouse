class_name SoundMenu2D
extends Control


var _player : AudioStreamPlayer3D



func set_player(p_player : AudioStreamPlayer3D) -> void:
	_player = p_player
	_on_volume_value_changed(%Volume.value)
	_on_range_value_changed(%Range.value)


func _on_volume_value_changed(value: float) -> void:
	if _player:
		_player.volume_db = linear_to_db(value)


func _on_range_value_changed(value: float) -> void:
	if _player:
		_player.unit_size = value
		_player.max_distance = value * 10
