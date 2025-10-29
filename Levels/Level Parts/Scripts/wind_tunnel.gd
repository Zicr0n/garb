extends Area2D

@export var DIRECTION : Vector2 = Vector2(0, -1)# up
@export var wind_strength : int = 10
@export var x_size : int = 50
@export var y_size : int = 50
var bodies_in_area : Array = []


func _physics_process(_delta: float) -> void:
	for body in bodies_in_area:
		body.velocity += wind_strength * DIRECTION.normalized()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		bodies_in_area.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		bodies_in_area.erase(body)
