extends VBoxContainer

@export var dropdown : OptionButton = null

signal value_changed(id)

func _ready() -> void:
	if dropdown:
		dropdown.item_selected.connect(func():
			value_changed.emit(dropdown.selected)
			)

func get_id():
	return dropdown.selected
