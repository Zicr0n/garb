extends HBoxContainer

@export var checkbox : CheckBox = null

signal value_changed(newValue)

func _ready() -> void:
	if checkbox:
		checkbox.button_up.connect(func():
			value_changed.emit(checkbox.button_pressed)
			)

func get_value():
	return checkbox.button_pressed
