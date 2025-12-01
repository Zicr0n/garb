extends PlayerState

@export var _fall_state : PlayerState = null
@export var _yank_duration : Timer = null
@export var _particle_emitter : CPUParticles2D = null

func enter():
	var _input = state_machine.input_component.move_dir_x()
	state_machine.move_component.yank(_input)
	_particle_emitter.emitting = true
	_yank_duration.start()

func process(_delta):
	if _yank_duration.time_left <= 0:
		return _fall_state
	return null

func physics_process(_delta):
	return null

func exit():
	state_machine.move_component.end_yank()
	state_machine.fall_source = state_machine.FALL_SOURCE.YANK
	_particle_emitter.emitting = false
