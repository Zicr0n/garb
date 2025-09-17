extends CharacterBody2D

@export var maxRunSpeed : int = 40
@export var runAcceleration : int = 1
@export var jumpPower : int = -500
var canJump : bool = false
@export var wallSLideSpeed : int = 1
@export var wallJumpVerticalPower : int = 3
@export var wallJumpHorizontalPower : int = 4

func _physics_process(delta: float) -> void:
	velocity.y += get_gravity().y * delta

	#check for input
	var inputX = Input.get_axis("move_left", "move_right")
	velocity.x = maxRunSpeed * inputX

	if Input.is_action_just_pressed("jump") and canJump:
		jump()

	move_and_slide()

	if is_on_floor():
		canJump = true

func jump():
	velocity.y = jumpPower
	canJump = false
