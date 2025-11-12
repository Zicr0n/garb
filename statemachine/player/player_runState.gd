extends PlayerState

@export var _idle_state : PlayerState = null;
@export var _jump_state : PlayerState = null;
@export var _fall_state : PlayerState = null;
@export var _yank_state : PlayerState = null;
@export var _dash_state : PlayerState = null;

var x_dir = 0

func enter():
	pass

func process(_delta):
	x_dir = state_machine.input_component.move_dir_x()

	if state_machine.input_component.is_yank_just_pressed():
		return _yank_state

	if state_machine.input_component.is_dash_just_pressed():
		return _dash_state

	if state_machine.input_component.is_jump_just_pressed():
		return _jump_state

	#if state_machine.move_component.is_interact_just_pressed():
		#state_machine._interract_area.activate()
	
	if x_dir == 0 and state_machine.move_component.not_moving():
		return _idle_state

	return null

func physics_process(delta):
	if !state_machine.move_component.grounded():
		return _fall_state
	
	state_machine.move_component.move_on_ground(x_dir, delta)
	
	return null

func exit():
	state_machine.fall_source = state_machine.FALL_SOURCE.PLATFORM
	
