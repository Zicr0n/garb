extends Control

var waiting_for_input = false

@export var ACTION : String = ""
var current_key = null
@onready var button: Button = $Button

func _ready() -> void:
	var actionEvent = InputMap.action_get_events(ACTION)[0]
	#current_key = actionEvent["keycode"]
	#print(current_key)

func _on_button_pressed() -> void:
	waiting_for_input = true
	
	

func _input(event: InputEvent) -> void:
	if waiting_for_input:
		var key = event.keycode
		
		if key == KEY_ESCAPE:
			waiting_for_input = false
			return
		
		InputMap.action_add_event(ACTION, key)

#func _process(delta: float) -> void:
	#button.text = current_key.to_string() if current_key != null else ""
