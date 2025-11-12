extends CharacterBody2D
class_name Player

const MAX_DASHES : int = 1
var dashes := MAX_DASHES
#
@onready var x: Label = $CanvasLayer/hud/velocities/X
@onready var y: Label = $CanvasLayer/hud/velocities/Y

#@onready var yankf: Node = $Statemachine/Yank
#
#@export var statemachine: PlayerStateMachine = null
#
#func _input(_event: InputEvent) -> void:
	#pass

func _physics_process(_delta: float) -> void:
	if is_on_floor():
		#statemachine.disabled = false
		dashes = MAX_DASHES
	#move_and_slide()

	x.text = "VEL_X : " + "%0.2f" % velocity.x
	y.text = "VEL_Y : " + "%0.2f" % velocity.y
