@tool
class_name Placeable
extends XRToolsPickable


signal touched


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


func pointer_event(event : XRToolsPointerEvent) -> void:
	# Ignore everything that isn't a press
	if event.event_type != XRToolsPointerEvent.Type.PRESSED:
		return

	# Handle delete on touch
	if Game.delete_on_touch:
		queue_free()
		return

	# Report touched
	touched.emit()
