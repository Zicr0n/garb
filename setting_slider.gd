extends PanelContainer

@export var slider : Slider = null

signal value_changed(newValue)

func _ready() -> void:
	if slider:
		slider.value_changed.connect(func():
			value_changed.emit(slider.value)
			)

func get_value():
	return slider.value
