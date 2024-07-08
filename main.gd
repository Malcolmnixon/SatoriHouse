extends Node3D


const SOUND_RENDER_LAYER := 0x80000
const SOUND_PHYSICS_LAYER := 0x80000000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.show_audio.connect(_on_show_audio)


func _on_show_audio(p_visible : bool) -> void:
	if p_visible:
		%XRCamera3D.cull_mask |= SOUND_RENDER_LAYER
		%LeftFingerPoke.mask |= SOUND_PHYSICS_LAYER
		%RightFingerPoke.mask |= SOUND_PHYSICS_LAYER
	else:
		%XRCamera3D.cull_mask &= ~SOUND_RENDER_LAYER
		%LeftFingerPoke.mask &= ~SOUND_PHYSICS_LAYER
		%RightFingerPoke.mask &= ~SOUND_PHYSICS_LAYER
