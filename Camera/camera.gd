extends Camera2D

@export var follow_speed := 5.0
@export var look_ahead_distance := 10
@export var player : CharacterBody2D = null

var target_pos := Vector2.ZERO

func _process(delta):
	if player:
		var look_ahead = player.velocity.normalized() * look_ahead_distance
		target_pos = player.global_position + look_ahead
		global_position = global_position.lerp(target_pos, delta * follow_speed)
