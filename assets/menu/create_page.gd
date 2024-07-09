@tool
extends MarginContainer


@export var library : DecorationLibrary


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Populate the items
	if library:
		for decoration in library.decorations:
			%ItemList.add_item(decoration.description, decoration.image)

	%CreateButton.pressed.connect(_on_create_button)

func _on_create_button() -> void:
	var selected : PackedInt32Array = %ItemList.get_selected_items()
	if selected.size() != 1:
		return

	# Get the decoration
	var index : int = selected[0]
	var decoration := library.decorations[index]

	# Trigger the creation of the item
	Game.create_decoration_selected(decoration)
