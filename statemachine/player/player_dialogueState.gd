extends PlayerState

@export var _idle_state : PlayerState = null

var is_finished = false

func enter():
	is_finished = false
	
	state_machine.interactor.on_interaction_finished.connect(interaction_end)

func process(_delta):
	if is_finished == true:
		return _idle_state

func physics_process(delta: float) -> void:
	state_machine.move_component.idle(delta)

func interaction_end():
	is_finished = true
	state_machine.interactor.on_interaction_finished.disconnect(interaction_end)
