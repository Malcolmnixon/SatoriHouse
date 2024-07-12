@tool
class_name Decoration
extends XRToolsPickable


signal touched


## Type of decoration
@export var type : DecorationType

## Snap angle
@export var snap_angle : float = 20.0

## Snap to ground
@export var ground_snap : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	dropped.connect(_on_dropped)


# Called when this object is touched
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


# Called when this object is dropped
func _on_dropped(_pickable) -> void:
	# Get the current transform
	var xform := global_transform
	var vec_x := xform.basis.x
	var vec_y := xform.basis.y
	var vec_z := xform.basis.z
	var vec_o := xform.origin

	# Decide if we're going to ground-snap
	var do_ground_snap := ground_snap and vec_o.y < 0.2

	# Decide if we're going to vertical-snap
	var angle := rad_to_deg(vec_y.angle_to(Vector3.UP))
	var do_vertical_snap := do_ground_snap or angle < snap_angle

	# Apply vertical-snap
	if do_vertical_snap:
		vec_y = Vector3.UP
		vec_z = xform.basis.x.cross(vec_y).normalized()
		vec_x = vec_y.cross(vec_z).normalized()

	# Apply ground-snap
	if do_ground_snap:
		vec_o = vec_o.slide(vec_y)

	# Write the snapped transform
	global_transform = Transform3D(Basis(vec_x, vec_y, vec_z), vec_o).orthonormalized()
