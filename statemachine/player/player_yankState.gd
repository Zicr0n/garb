extends PlayerState

@export var _fall_state : PlayerState = null
@export var _yank_duration : Timer = null
@export var _particle_emitter : CPUParticles2D = null

func enter():
	var is_yanking = state_machine.move_component.yank()
	if !is_yanking:
		return _fall_state
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
	_particle_emitter.emitting = false
