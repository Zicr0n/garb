extends PlayerState

@export var _fall_state : PlayerState = null

var dir_x = 0

var has_released_jump = false

func enter():
	state_machine.move_component.jump()
	
	if Input.is_action_pressed("jump"):
		has_released_jump = false
	else:
		state_machine.move_component.variable_jump()
		
		has_released_jump = true

func process(_delta):
	dir_x = state_machine.input_component.move_dir_x()

	return null

func input(event : InputEvent):
	if event.is_action_released("jump"):
		if has_released_jump == false:
			has_released_jump = true
			state_machine.move_component.variable_jump()
	
	return null

func physics_process(delta):
	state_machine.move_component.fall(delta)
	if state_machine.move_component.is_falling():
		return _fall_state
	
	state_machine.move_component.move_in_air(dir_x, delta)
	
	return null

func exit():
	state_machine.fall_source = state_machine.FALL_SOURCE.OTHER
	
