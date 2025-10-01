extends PlayerState

@export var _idle_state : PlayerState = null
@export var _jump_state : PlayerState = null
@export var _fall_state : PlayerState = null

var x_dir = 0

func enter():
	pass
	#print("Entered Run State")

func process(_delta):
	x_dir = state_machine.input_component.move_dir_x()
	
	if x_dir == 0:
		return _idle_state
	
	if state_machine.input_component.is_jump_just_pressed():
		return _jump_state
	
	return null

func physics_process(delta):
	if !state_machine.move_component.grounded():
		return _fall_state
	
	state_machine.move_component.move_on_ground(x_dir, delta)
	
	return null
