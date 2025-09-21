extends Node
class_name PlayerMoveComponent

@export var characterBody2D : CharacterBody2D = null

@export var MOVE_SPEED_GROUND : float = 100.0

func move_on_ground(direction : float) -> void:
	characterBody2D.velocity.x = direction * MOVE_SPEED_GROUND

func _physics_process(dt) -> void:
	characterBody2D.move_and_slide()
