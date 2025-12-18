extends PlayerState

@export var _fall_state : PlayerState = null
@export var _walljump_state : PlayerState = null
@export var _dash_state: PlayerState = null
@export var _yank_state: PlayerState = null

@export var jump_particles : GPUParticles2D = null

var dir_x = 0

var has_released_jump = false

func enter():
	state_machine.move_component.jump()
	
	if jump_particles:
		jump_particles.global_position = state_machine.feet_positon.global_position
		jump_particles.emitting = true
	
	if Input.is_action_pressed("jump"):
		has_released_jump = false
	else:
		state_machine.move_component.variable_jump()
		
		has_released_jump = true

func process(_delta):
	dir_x = state_machine.input_component.move_dir_x()

	if state_machine.input_component.is_yank_just_pressed():
		return _yank_state

	return null

func input(event : InputEvent):
	if event.is_action_released("jump"):
		if has_released_jump == false:
			has_released_jump = true
			state_machine.move_component.variable_jump()
	
	return null

func physics_process(delta):
	state_machine.move_component.fall(delta)
	
	if state_machine.input_component.is_yank_just_pressed():
		if state_machine.move_component.can_yank():
			return _yank_state
	
	if state_machine.move_component.is_falling():
		return _fall_state
	
	if state_machine.input_component.is_jump_just_pressed():
		if state_machine.move_component.is_wall_left() || state_machine.move_component.is_wall_right():
			return _walljump_state
	
	if state_machine.input_component.is_dash_just_pressed() and state_machine.character.dashes > 0:
		return _dash_state
	
	state_machine.move_component.move_in_air(dir_x, delta)
	
	return null

func exit():
	state_machine.fall_source = state_machine.FALL_SOURCE.OTHER
	
