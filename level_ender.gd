extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	GameManager.on_level_ended()
	queue_free()
