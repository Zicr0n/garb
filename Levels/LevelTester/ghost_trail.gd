extends Node

@export var player : CharacterBody2D = null
@export var timer : Timer = null
@export var interval : float = 1.0
@export var lifetime : float = 1.0

@onready var ghost_scene : PackedScene = preload("res://Levels/LevelTester/dash_ghost.tscn")
var current_time : float = 0.0

var playerPositions := []

#func _ready() -> void:
#	timer.wait_time = interval

func _process(delta: float) -> void:
	if timer.time_left > 0:
		if current_time >= interval:
			current_time = 0
			_on_interval_timeout()
		else:
			current_time += delta
	else:
		current_time = 99

func _on_interval_timeout() -> void:
	if playerPositions.size() > 0 and player.global_position == playerPositions.back():
		return
	playerPositions.append(player.global_position)
	var snapshot := Sprite2D.new()
	var sprite_child := player.get_node_or_null("Sprite2D")

	if sprite_child:
		snapshot.texture = sprite_child.texture
		snapshot.flip_h = sprite_child.flip_h
		snapshot.scale = sprite_child.scale
		snapshot.modulate = Color(1, 1, 1, 0.2)# transparent so it looks ghostly

	var ghost_instance = ghost_scene.instantiate()
	ghost_instance.add_child(snapshot)
	ghost_instance.global_position = player.global_position

	ghost_instance.lifetime = lifetime

	get_tree().root.add_child(ghost_instance)
	playerPositions.append(snapshot.global_position)
