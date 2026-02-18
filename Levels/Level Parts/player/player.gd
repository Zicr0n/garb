extends CharacterBody2D
class_name Player

const MAX_DASHES : int = 1
var dashes := MAX_DASHES

@onready var x: Label = $CanvasLayer/hud/velocities/X
@onready var y: Label = $CanvasLayer/hud/velocities/Y

@onready var statemachine : PlayerStateMachine =  $Components/Statemachine
@onready var sprite : Sprite2D = $Sprite2D
@onready var instructions : Node2D = $Instructions
var cur_flip = false

var was_on_floor = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		AudioSystem.play_sound("wrong")

func _ready() -> void:
	enable()

func disable():
	statemachine.disabled = true

func trigger_instruction(instruction : String):
	for child in instructions.get_children():
		child.visible = false
	
	var node : Node2D= instructions.get_node(instruction)
	
	if node:
		node.visible = true
	
	await wait(4)
	
	node.hide()

func wait(seconds):
	await get_tree().create_timer(seconds).timeout

func enable():
	statemachine.disabled = false

func _physics_process(_delta: float) -> void:
	if is_on_floor() and statemachine.current_state.name != "Dash":
		#statemachine.disabled = false
		dashes = MAX_DASHES
	#move_and_slide()

	x.text = "VEL_X : " + "%0.2f" % velocity.x
	y.text = "VEL_Y : " + "%0.2f" % velocity.y
	
	if velocity.x > 0:
		cur_flip = false
	elif velocity.x < 0:
		cur_flip = true
	
	sprite.flip_h = cur_flip

func custom_set_velocity(new_velocity):
	statemachine.move_component.set_velocity(new_velocity)
