extends PlayerState

@export var idle_state : PlayerState = null
@export var jump_state : PlayerState = null

func enter():
	print("Entered Run State")

func process(_delta):
	var x_dir = state_machine.input_component.move_dir_x()
	
	if x_dir == 0:
		return idle_state
	
	state_machine.move_component.move_on_ground(x_dir)
	
	return null
