extends PanelContainer


signal close_pressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_tab_buttons()


func _on_previous_button_pressed() -> void:
	%Tab.select_previous_available()
	_update_tab_buttons()


func _on_next_button_pressed() -> void:
	%Tab.select_next_available()
	_update_tab_buttons()


func _on_close_button_pressed() -> void:
	close_pressed.emit()


func _update_tab_buttons() -> void:
	%PreviousButton.disabled = %Tab.current_tab == 0
	%NextButton.disabled = %Tab.current_tab == %Tab.get_tab_count() - 1
