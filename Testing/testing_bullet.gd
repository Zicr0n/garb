extends Area2D

var benchmark_node : Node2D = null
var speed : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	global_position += speed

func _on_body_entered(body: Node2D) -> void:
	benchmark_node.kill(self)
