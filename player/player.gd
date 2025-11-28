extends CharacterBody2D
class_name Player

const MAX_DASHES : int = 1
var dashes := MAX_DASHES

@onready var x: Label = $CanvasLayer/hud/velocities/X
@onready var y: Label = $CanvasLayer/hud/velocities/Y

@onready var statemachine : PlayerStateMachine =  $Components/Statemachine
var was_on_floor = false

func _ready() -> void:
	enable()

func disable():
	statemachine.disabled = true

func enable():
	statemachine.disabled = false

func _physics_process(_delta: float) -> void:
	if is_on_floor() and statemachine.current_state.name != "Dash":
		#statemachine.disabled = false
		dashes = MAX_DASHES
	#move_and_slide()

	x.text = "VEL_X : " + "%0.2f" % velocity.x
	y.text = "VEL_Y : " + "%0.2f" % velocity.y

func custom_set_velocity(new_velocity):
	statemachine.move_component.set_velocity(new_velocity)
