extends Node
class_name PlayerMoveComponent

@export var characterBody2D : CharacterBody2D = null

@export var JUMP_HEIGHT : float = 400.0
@export var GRAVITY_MULTIPLIER : float = 1.5

@export_category("GROUND MOVEMENT")
@export var MOVE_SPEED_GROUND : float = 250.0
@export var ACCELERATION_GROUND : float = 5000.0
@export var DECELERATION_GROUND : float = 3000.0
var _current_move_speed : float = 0.0

@export_category("AIR MOVEMENT")
@export var MOVE_SPEED_AIR : float = 250
@export var ACCELERATION_AIR : float = 5000.0
@export var DECELERATION_AIR : float = 3000.0

func move_on_ground(direction : float, _dt : float) -> void:
	#_current_move_speed = move_toward(_current_move_speed, MOVE_SPEED_GROUND * direction, ACCELERATION_GROUND * dt)
	_current_move_speed = MOVE_SPEED_GROUND * direction
	characterBody2D.velocity.x = _current_move_speed

func variable_jump():
	characterBody2D.velocity.y *= 0.5

func idle(dt):
	_current_move_speed = move_toward(_current_move_speed, 0, DECELERATION_GROUND * dt)
	characterBody2D.velocity.x = _current_move_speed

func move_in_air(direction : float, _dt) -> void:
	#_current_move_speed = move_toward(_current_move_speed, MOVE_SPEED_AIR * direction, ACCELERATION_AIR * dt)
	_current_move_speed = MOVE_SPEED_AIR * direction
	characterBody2D.velocity.x = _current_move_speed

func _physics_process(dt) -> void:
	if !grounded():
		fall(dt)
	
	characterBody2D.move_and_slide()

func fall(dt):
	characterBody2D.velocity.y += characterBody2D.get_gravity().y * dt * GRAVITY_MULTIPLIER

func grounded() -> bool:
	return characterBody2D.is_on_floor()

func jump():
	characterBody2D.velocity.y = -JUMP_HEIGHT

func is_falling() -> bool:
	return characterBody2D.velocity.y >= 0.0
