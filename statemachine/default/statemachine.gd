extends Node
class_name StateMachine

var parent = null
@export var call_input : bool = false
@export var start_state : State = null
var current_state : State = null
var previous_state : State = null

func init(set_parent):
	parent = set_parent
	
	if start_state == null:
		print("NO START STATE FOUND")
		return
	
	for child in get_children():
		if child is State:
			var state : State = child
			state.state_machine = self
	
	set_state(start_state)

func set_state(new_state : State):
	if current_state:
		current_state.exit()
		previous_state = current_state
	
	current_state = new_state
	current_state.enter()
	

func _input(event):
	if call_input:
		if current_state:
			var new_state : State = current_state.input(event)
			
			if new_state != null:
				# Returned a state, change to it
				set_state(new_state)

func _process(delta):
	if current_state:
		var new_state : State = current_state.process(delta)
		
		if new_state != null:
			# Returned a state, change to it
			set_state(new_state)

func _physics_process(delta):
	if current_state:
		var new_state : State = current_state.physics_process(delta)
		
		if new_state != null:
			# Returned a state, change to it
			set_state(new_state)
