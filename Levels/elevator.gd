extends AnimatableBody2D

@export var playerDetect : Area2D = null
@export var animPlayer : AnimationPlayer = null
var player : CharacterBody2D = null
func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	animPlayer.play("Elevator")

func bounce():
	if player:
		player.velocity.y =- 1000
	player = null
