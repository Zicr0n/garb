extends PlayerState

var killer_hitbox : Hitbox = null
@export var death_particles : GPUParticles2D = null
@export var death_timer : Timer = null

func enter():
	death_timer.connect("timeout", die)
	
	state_machine.animation_player.play("death")
	
	state_machine.move_component.stop_moving()
	killer_hitbox = state_machine.health_component.last_hitter
	
	if death_particles:
		death_particles.global_position = state_machine.character.global_position
		await state_machine.animation_player.animation_finished
		death_particles.emitting = true
	
	death_timer.start()

func die():
	# Reload to last checkpoint, play transistion. this should be managed by an exterior manager
	GameManager.player_died(state_machine.character)

func exit():
	death_timer.disconnect("timeout", die)
