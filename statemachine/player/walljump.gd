extends PlayerState

@export var _fall_state : PlayerState = null
@onready var walljump_timer: Timer = $WalljumpDuration
@export var _dash_state: PlayerState = null;

var dir_x = 0

var has_released_jump = false
var is_wall_kick = false


func enter():
	is_wall_kick = false
	walljump_timer.start()
	var inputDir = state_machine.input_component.move_dir_x()
	state_machine.move_component.wall_jump(inputDir)
	
	if inputDir != 0:
		is_wall_kick = true
	
	walljump_timer.wait_time = state_machine.move_component.WALL_JUMP_DURATION_LONG if is_wall_kick == true else state_machine.move_component.WALL_JUMP_DURATION_SHORT
	
	if Input.is_action_pressed("jump"):
		has_released_jump = false
	else:
		state_machine.move_component.variable_jump()
		has_released_jump = true
	

func process(_delta):
	dir_x = state_machine.input_component.move_dir_x()

	if state_machine.input_component.is_dash_just_pressed() and state_machine.character.dashes > 0:
		return _dash_state

	return null

#func input(event : InputEvent):
	#if event.is_action_released("jump"):
		#if has_released_jump == false:
			#has_released_jump = true
			#state_machine.move_component.variable_jump()
	#return null

func physics_process(delta):
	state_machine.move_component.fall(delta)
	
	if walljump_timer.time_left <= 0:
		return _fall_state
		
	return null

func exit():
	state_machine.fall_source = state_machine.FALL_SOURCE.OTHER
	
	walljump_timer.stop()
	
