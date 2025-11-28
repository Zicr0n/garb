extends Area2D

@export var bounce_power = 500

func _on_body_entered(body: Node2D) -> void:
	var direction = Vector2(cos(rotation - (PI/2)), sin(rotation - (PI/2)))
	print(rotation, direction)
	body.statemachine.move_component.custom_set_velocity((direction * bounce_power))
