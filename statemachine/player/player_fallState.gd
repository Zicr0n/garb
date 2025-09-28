extends PlayerState

@export var _idle_state : PlayerState = null
@export var _run_state : PlayerState = null

var dir_x = 0

func enter():
	pass

func process(_delta):
	dir_x = state_machine.input_component.move_dir_x()

func physics_process(_delta: float):
	#state_machine.move_component.fall(delta)
	
	if state_machine.move_component.grounded():
		if state_machine.input_component.move_dir_x() != 0:
			return _run_state
		else:
			return _idle_state
	
	state_machine.move_component.move_in_air(dir_x, _delta)
	
	return null
