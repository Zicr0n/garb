extends Node2D

@export var timer : Timer = null

var lifetime : float = 9999

func _ready() -> void:
	timer.wait_time = lifetime
	timer.start()
	print(lifetime)

func _on_timer_timeout() -> void:
	queue_free()
