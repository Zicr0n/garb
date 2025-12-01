extends Node
class_name PlayerMoveComponent

@export var characterBody2D : CharacterBody2D = null
@export var yankDetector : YankDetector = null

@export_category("GROUND MOVEMENT")
@export var MOVE_SPEED_GROUND : float = 100.0
@export var ACCELERATION_GROUND : float = 100.0
@export var DECELERATION_GROUND : float = 100.0
@export var TURNING_ACCELERATION_GROUND : float = 100.0
@export var TURNING_THRESHOLD_SPEED : float = 280.0
var _current_move_speed : float = 0.0

@export_category("JUMP")
@export var MAX_JUMP_HEIGHT : float = 400.0

@export_category("FALLING")
@export var GRAVITY : float = 200.0
@export var GRAVITY_MULTIPLIER : float = 1.5 ## Gravity Multiplier, general
@export var FALL_MULTIPLIER : float = 1.2 ## Applies to make falling faster than jumping
@export var FAST_FALL_MULTIPLIER : float = 1.2 ## Applies to make falling faster than jumping
@export var MAX_FALL_SPEED : float = 40.0
@export var MAX_FAST_FALL_SPEED : float = 60.0

@export_category("WALL JUMP")
@export var VERTICAL_WALL_JUMP_HEIGHT = 400
@export var HORIZONTAL_WALL_JUMP_HEIGHT = 400
@export var HORIZONTAL_WALL_JUMP_HEIGHT_ON_INPUT = 600
@export var WALL_JUMP_DURATION_LONG :float = 0.15
@export var WALL_JUMP_DURATION_SHORT :float = 0.075
@export var WALL_LEFT_RAY : RayCast2D = null
@export var WALL_RIGHT_RAY : RayCast2D = null
@export var WALL_LEFT_RAY_BOTTOM : RayCast2D = null
@export var WALL_RIGHT_RAY_BOTTOM : RayCast2D = null

@export_category("AIR MOVEMENT")
@export var MOVE_SPEED_AIR : float = 250.0
@export var ACCELERATION_AIR : float = 1500.0
@export var DECELERATION_AIR : float = 3000.0

@export_category("YANK")
@export var YANK_POWER : float = 600

@export_category("DASH")
@export var DASH_VELOCITY : float = 700

var last_move_dir = 1
var last_target_speed = 0
var is_turning = false
	
############
## UPDATE ##
############

func _physics_process(_dt) -> void:
	characterBody2D.move_and_slide()

func custom_set_velocity(new_velocity):
	pass

############
## GROUND ##
############
func idle(dt):
	_current_move_speed = move_toward(_current_move_speed, 0, DECELERATION_GROUND * dt)
	characterBody2D.velocity.x = _current_move_speed
	characterBody2D.velocity.y = 0

func move_on_ground(direction : float, dt : float) -> void:
	var target_speed = MOVE_SPEED_GROUND * direction
	
	var was_turning = is_turning
	
	if sign(target_speed) != sign(characterBody2D.velocity.x) and characterBody2D.velocity.x != 0 and direction != 0:
		var absSpeed = abs(characterBody2D.velocity.x)
		if absSpeed > TURNING_THRESHOLD_SPEED:
			is_turning = true
		else:
			is_turning = false
			direction = sign(characterBody2D.velocity.x)
	elif direction == 0:
		is_turning = false
	elif sign(target_speed) == sign(characterBody2D.velocity.x):
		is_turning = false
	
	var accel = TURNING_ACCELERATION_GROUND if is_turning else ACCELERATION_GROUND
	
	if direction != 0:
		characterBody2D.velocity.x = move_toward(characterBody2D.velocity.x, target_speed, accel * dt)
	else:
		characterBody2D.velocity.x = move_toward(characterBody2D.velocity.x, 0, DECELERATION_GROUND * dt)

	last_target_speed = target_speed

	was_turning = is_turning

func grounded() -> bool:
	return characterBody2D.is_on_floor()

func not_moving() -> bool:
	return abs(characterBody2D.velocity.x) < 1

##########
## JUMP ##
##########
func jump():
	characterBody2D.velocity.y = -MAX_JUMP_HEIGHT

func variable_jump():
	characterBody2D.velocity.y *= 0.5

##########
## FALL ##
##########
func move_in_air(direction : float, dt, air_fric_multi = 1.0) -> void:
	var target_speed := MOVE_SPEED_AIR * direction
	
	if direction != 0:
		characterBody2D.velocity.x = move_toward(characterBody2D.velocity.x, target_speed, ACCELERATION_AIR * dt * air_fric_multi)
	else:
		if characterBody2D.get_platform_velocity().x != 0.0:
			characterBody2D.velocity.x = move_toward(characterBody2D.velocity.x, characterBody2D.get_platform_velocity().x, DECELERATION_AIR * dt * air_fric_multi)
		else:
			characterBody2D.velocity.x = move_toward(characterBody2D.velocity.x, 0.0, dt * DECELERATION_AIR)
		

func fall(dt, _multiplier:=0):
	var multi := FALL_MULTIPLIER if characterBody2D.velocity.y > 0.0 else 1.0

	characterBody2D.velocity.y += GRAVITY * dt * multi
	characterBody2D.velocity.y = clampf(characterBody2D.velocity.y, -99999, MAX_FALL_SPEED)
	

func fast_fall(dt):
	characterBody2D.velocity.y += GRAVITY * dt * FAST_FALL_MULTIPLIER
	characterBody2D.velocity.y = clampf(characterBody2D.velocity.y, -99999, MAX_FAST_FALL_SPEED)

func is_falling() -> bool:
	return characterBody2D.velocity.y >= 0.0

##########
## YANK ##
##########
func yank(input_dir):
	var nearest_point : YankPoint = yankDetector.get_nearest_point()
	
	if nearest_point:
		var yank_dir = (nearest_point.global_position - characterBody2D.global_position).normalized()
		var dist_to_point = nearest_point.global_position.distance_to(characterBody2D.global_position)
		var dist_multiplier = lerp(0.5, 1.5, (dist_to_point / nearest_point.radius))
		characterBody2D.velocity = yank_dir * YANK_POWER * dist_multiplier  + Vector2(input_dir * MOVE_SPEED_AIR, 0)
		return true
	else:
		return false

func can_yank() -> bool:
	return yankDetector.get_nearest_point() != null

func end_yank():
	characterBody2D.velocity *= 0.5

##########
## DASH ##
##########
func dash(dir : Vector2) -> bool:
	if dir != Vector2.ZERO:
		characterBody2D.velocity = dir * DASH_VELOCITY
		characterBody2D.dashes -= 1
		return true
	else:
		return false

func end_dash():
	characterBody2D.velocity *= 0.5

##############
## WALLJUMP ##
##############
func wall_jump(input : float = 0.0):
	if grounded(): return
	
	var dir = 1
	
	if is_wall_left():
		dir = 1
	elif is_wall_right():
		dir = -1
	
	var jump_power = HORIZONTAL_WALL_JUMP_HEIGHT if input == 0.0 else HORIZONTAL_WALL_JUMP_HEIGHT_ON_INPUT
	characterBody2D.velocity = Vector2(jump_power * dir,-VERTICAL_WALL_JUMP_HEIGHT * 1.0)

func is_wall_left():
	return WALL_LEFT_RAY.is_colliding() || WALL_LEFT_RAY_BOTTOM.is_colliding()

func is_wall_right():
	return WALL_RIGHT_RAY.is_colliding() || WALL_RIGHT_RAY_BOTTOM.is_colliding()
