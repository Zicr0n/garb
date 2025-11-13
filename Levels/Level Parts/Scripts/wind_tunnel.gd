extends Area2D

@export var DIRECTION : Vector2 = Vector2(0, -1)# up
@export var wind_strength : int = 1000
@export var MAX_SPEED : int = 1000
@export var x_size : int = 50
@export var y_size : int = 50
var bodies_in_area : Array = []

func _physics_process(delta: float) -> void:
	for body in bodies_in_area:
		body.velocity += wind_strength * DIRECTION.normalized() * delta
		body.velocity.x = clamp(body.velocity.x, -MAX_SPEED, MAX_SPEED)
		body.velocity.y = clamp(body.velocity.y, -MAX_SPEED, MAX_SPEED)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		bodies_in_area.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		bodies_in_area.erase(body)
