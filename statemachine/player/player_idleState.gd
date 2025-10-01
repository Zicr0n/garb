extends PlayerState
class_name PlayerIdleState

@export var _jump_state : PlayerState = null;
@export var _run_state : PlayerState = null;
@export var _fall_state : PlayerState = null;

func enter():
	pass

func process(_delta):
	if state_machine.input_component.move_dir_x() != 0:
		return _run_state;
	
	if state_machine.input_component.is_jump_just_pressed():
		return _jump_state
	
	return null

func physics_process(delta):
	if !state_machine.move_component.grounded():
		return _fall_state
	
	state_machine.move_component.idle(delta)
	
	return null
