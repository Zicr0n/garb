extends PlayerState

func enter():
	print("Player Died")
	die()

func die():
	# Reload to last checkpoint, play transistion. this should be managed by an exterior manager
	get_tree().reload_current_scene()
