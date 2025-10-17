extends CharacterBody2D
class_name Player

@onready var x: Label = $CanvasLayer/hud/velocities/X
@onready var y: Label = $CanvasLayer/hud/velocities/Y

@onready var yankf: Node = $Statemachine/Yank

@onready var statemachine: PlayerStateMachine = $Statemachine

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_on_floor():
		statemachine.disabled = false
	move_and_slide()
	
	x.text = "VEL_X : " + "%0.2f" % velocity.x
	y.text = "VEL_Y : " + "%0.2f" % velocity.y
