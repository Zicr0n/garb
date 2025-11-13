extends Area2D

@export var interaction_area : InteractArea = null

func _on_body_entered(_body: Node2D) -> void:
	interaction_area.activate()
