extends PlayerState

func enter():
	die()

func die():
	# Reload to last checkpoint, play transistion. this should be managed by an exterior manager
	GameManager.player_died(state_machine.character)
