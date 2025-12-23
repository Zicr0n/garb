extends Area2D
class_name Collectible

@export var animated_sprite: AnimatedSprite2D = null

var shiningTimeMin = 8.0
var shiningTimeMax = 12.0
var next_shine_time = 0.0
var time = 0.0

func _process(delta: float) -> void:
	time += delta
	
	if time > next_shine_time:
		next_shine_time = time + randf_range(shiningTimeMin, shiningTimeMax)
		animated_sprite.play("shine")
		await animated_sprite.animation_finished
		animated_sprite.play("default")
