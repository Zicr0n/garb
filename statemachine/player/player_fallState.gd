extends PlayerState

@export var _idle_state : PlayerState = null
@export var _run_state : PlayerState = null
@export var _jump_state: PlayerState = null
@export var _dash_state: PlayerState = null
@export var _walljump_state: PlayerState = null
@export var _yank_state : PlayerState = null;

@onready var _coyote_timer: Timer = $coyote_timer
@onready var buffer_timer: Timer = $buffer_timer

var dir_x = 0
var fastfall = false

func enter():
	if state_machine.fall_source == state_machine.FALL_SOURCE.PLATFORM:
		_coyote_timer.start()
		return
	
	if state_machine.fall_source == state_machine.FALL_SOURCE.WALL:
		return

func process(_delta):
	dir_x = state_machine.input_component.move_dir_x()
	#fastfall = state_machine.input_component.move_down()

	if state_machine.input_component.is_yank_just_pressed():
		return _yank_state

	if _coyote_timer.time_left > 0 and state_machine.input_component.is_jump_just_pressed():
		_coyote_timer.stop()
		return _jump_state

	if state_machine.input_component.is_jump_just_pressed():
		if state_machine.move_component.is_wall_left() || state_machine.move_component.is_wall_right():
			return _walljump_state
			
		buffer_timer.start()

	if state_machine.input_component.is_dash_just_pressed():
		return _dash_state

func physics_process(delta: float):
	if state_machine.input_component.move_down():
		state_machine.move_component.fast_fall(delta)
	else:
		state_machine.move_component.fall(delta)

	if state_machine.move_component.grounded():
		if buffer_timer.time_left > 0:
			return _jump_state
		if state_machine.input_component.move_dir_x() != 0:
			return _run_state
		else:
			return _idle_state
	
	state_machine.move_component.move_in_air(dir_x, delta)
	
	return null
