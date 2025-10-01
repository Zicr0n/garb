extends Area2D

var player : CharacterBody2D = null

func _on_body_entered(body: Node2D) -> void:
	print("body entered area! " + body.name)
	player = body


func _on_body_exited(body: Node2D) -> void:
	print("body exited area ! " + body.name)
	player = null
	
