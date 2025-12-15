extends Area2D

@export var bounce_power = 500
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	var direction = Vector2(cos(rotation - (PI/2)), sin(rotation - (PI/2)))
	body.statemachine.move_component.custom_set_velocity((direction * bounce_power))
	animated_sprite_2d.play("bounce")
