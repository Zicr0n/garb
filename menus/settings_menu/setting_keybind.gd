extends Control

var waiting_for_input = false

@export var ACTION : String = ""
@export var action_name : String = ""
var current_key = null
@onready var button: Button = $Button
@onready var label: Label = $VBoxContainer/Label

@export var key_1 : KeybindHolder = null

func _ready() -> void:
	label.text = action_name
	var actionEvent = InputMap.action_get_events(ACTION)
	key_1.my_key = actionEvent[0].physical_keycode

func _on_button_pressed() -> void:
	waiting_for_input = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouse: return
	
	if waiting_for_input:
		if event.is_pressed():
			var key = event.keycode
			print(key)
			
			if key == KEY_ESCAPE:
				waiting_for_input = false
				return
			
			InputMap.action_erase_events(ACTION)
			InputMap.action_add_event(ACTION, event)
			
			key_1.my_key = key
			
			waiting_for_input = false
			
			return

#func _process(delta: float) -> void:
	#button.text = current_key.to_string() if current_key != null else ""
