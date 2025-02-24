@tool
class_name Pet
extends Decoration


#@export var idle : PetAnimation

#@export var pokes : 

@export var audio : AudioStreamPlayer3D

## Idle Animations
@export var idle_animation : String = "Idle"

## Poke Animation Chains
@export var poke_animations : Array[PetAnimation] = []


# Animation player
var _player : AnimationPlayer

# Current animation queue
var _current := PackedStringArray()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	# Skip if editor
	if Engine.is_editor_hint():
		return

	# Listen for touches
	touched.connect(_on_touched)

	# Get the animation player
	var players := find_children("*", "AnimationPlayer", true, true)
	if players.size() == 1:
		_player = players[0] as AnimationPlayer

	# If animation supported then play the idle animation
	if _player:
		# Play the idle animation
		_player.play(idle_animation)

		# Listen for animation changes
		_player.animation_finished.connect(_on_animation_finished)


# Called when the pet is touched
func _on_touched() -> void:
	# Ignore if no poke animations
	if poke_animations.size() == 0:
		return

	# Ignore if working through a list
	if _current.size() != 0:
		return

	# Pick an animation
	var i := randi() % poke_animations.size()
	var animation := poke_animations[i]

	# Play the sound
	if audio and animation.audio:
		audio.stream = animation.audio
		audio.play()

	# If animation supported then start the animation
	if _player:
		_current = animation.animations.duplicate()
		_play_next()


# Play the next animation
func _play_next() -> void:
	# If at end then play idle
	if _current.size() == 0:
		_player.play(idle_animation)
		return

	# Pop the next animation
	var next := _current[0]
	_current.remove_at(0)

	# Play the next animation
	_player.play(next)


# Called when an animation finishes
func _on_animation_finished(_name : String) -> void:
	_play_next()
