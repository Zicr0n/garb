extends Node2D

@export var tilemap : Node2D = null
@export var scroll_speed : float = 250.0

func _process(delta: float) -> void:
	if tilemap:
		tilemap.global_position.y -= delta * scroll_speed

func load_game():
	GameManager.load_level("level1")
