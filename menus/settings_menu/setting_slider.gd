extends PanelContainer
class_name SettingSlider

@export var slider : Slider = null
@export var text : String = "Text"
@export var min_val : float = 0.0
@export var max_val : float = 1.0
@export var step : float = 0.1

@onready var label: Label = $Setting_Slider/Label

signal value_changed(newValue)

func _ready() -> void:
	slider.value_changed.connect(emits_signal)
	label.text = text
	slider.min_value = min_val
	slider.max_value = max_val
	slider.step = step

func emits_signal(_va):
	value_changed.emit(slider.value)

func get_value():
	return slider.value

func set_value(val):
	if val != null:
		slider.value = val
	else:
		val = 1.0
