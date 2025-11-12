extends PlayerState

@export var _idle_state : PlayerState = null

func enter():
	state_machine.character.velocity = Vector2.ZERO
	state_machine._interract_area.dialogue_finished.connect(exit)

func process(_delta):
	return null

func physics_process(_delta):
	return null

func exit():
	return _idle_state
