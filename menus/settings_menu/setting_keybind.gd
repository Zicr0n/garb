extends Control

var waiting_for_input = false

@export var ACTION : String = ""
@export var action_name : String = ""
@export var key_1 : KeybindHolder = null

var current_key = null
@onready var label: Label = $VBoxContainer/Label

var config : ConfigFile = null
var keybinds_section = "keybinds"

func _ready() -> void:
	label.text = action_name
	
	config = SavingSystem.config_file
	
	if config == null:
		return
	
	var default = InputMap.action_get_events(ACTION)[0].physical_keycode
	var value = config.get_value(keybinds_section, ACTION, default)
	
	set_keybind(value)

func _on_button_pressed() -> void:
	waiting_for_input = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouse: return
	
	if waiting_for_input:
		if event.is_pressed():
			var key = event.keycode
			
			if key == KEY_ESCAPE:
				waiting_for_input = false
				return
			
			set_keybind(key)
			
			waiting_for_input = false
			
			return

func set_keybind(keycode):
	var event : InputEventKey = InputEventKey.new()
	event.keycode = keycode
	
	InputMap.action_erase_events(ACTION)
	InputMap.action_add_event(ACTION, event)
	
	key_1.my_key = keycode
	
	config.set_value(keybinds_section, ACTION, keycode)
	
	SavingSystem.save_config()
