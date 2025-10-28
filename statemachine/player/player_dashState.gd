extends PlayerState

@export var _idle_state : PlayerState = null
@export var _fall_state : PlayerState = null
@export var _dash_duration : Timer = null

func enter():
	if state_machine.character.dashes <= 0:
		return _fall_state

	state_machine.move_component.dash(state_machine.input_component.aim_dash())
	_dash_duration.start()

func process(_delta):
	if _dash_duration.time_left <= 0:
		return _fall_state
	return null

func physics_process(_delta):
	if state_machine.move_component.grounded():
		return _idle_state

func exit():
	state_machine.move_component.end_dash()
