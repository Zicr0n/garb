extends Area2D

var player : CharacterBody2D = null

func _on_body_entered(body: Node2D) -> void:
	player = body


func _on_body_exited(_body: Node2D) -> void:
	player = null
