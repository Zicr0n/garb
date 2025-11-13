extends AnimatableBody2D
class_name MovingPlatform

@onready var start_position: Marker2D = $Independent/StartPosition
@onready var end_position: Marker2D = $Independent/EndPosition
@onready var wait_timer : Timer = $WaitTime
@onready var target = start_position

@export var MAX_MOVE_SPEED : float = 100.0
@export var ACCELERATION : float = 100.0
var _current_move_speed = 0.0
var velocity = Vector2.ZERO

func _ready() -> void:
	global_position = start_position.global_position
	target = end_position

func _physics_process(delta: float) -> void:
	if wait_timer.time_left > 0:
		return
	
	#_current_move_speed = move_toward(_current_move_speed, MAX_MOVE_SPEED, delta * ACCELERATION)
	_current_move_speed = MAX_MOVE_SPEED
	var direction = global_position.direction_to(target.global_position)
	velocity = lerp(velocity, direction * _current_move_speed, 5 * delta)
	
	#print("distance" + str(global_position.distance_to(target.global_position)))
	
	move_and_collide(velocity * delta)
	
	if global_position.distance_to(target.global_position) <= 1:
		change_target()

func change_target():
	wait_timer.start()
	_current_move_speed = 0
	
	if target == start_position:
		target = end_position
	else:
		target = start_position
