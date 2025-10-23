extends PlayerState

@export var _idle_state : PlayerState = null
@export var _fall_state : PlayerState = null
@export var _yank_duration : Timer = null

func enter():
	state_machine.move_component.yank()
	_yank_duration.start()

func process(_delta):
	if _yank_duration.time_left <= 0:
		return _fall_state
	return null

func physics_process(_delta):
	if state_machine.move_component.grounded():
		return _idle_state

	return null

func exit():
	pass
