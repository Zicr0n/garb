extends PlayerState

@export var _idle_state : PlayerState = null

var is_finished = false

func enter():
	is_finished = false
	
	state_machine.character.velocity = Vector2.ZERO
	state_machine.interactor.on_interaction_finished.connect(interaction_end)

func process(_delta):
	if is_finished == true:
		return _idle_state

func interaction_end():
	is_finished = true
	state_machine.interactor.on_interaction_finished.disconnect(interaction_end)
