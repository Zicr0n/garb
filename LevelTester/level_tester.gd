extends Node

@export var player : CharacterBody2D = null
@export var timer : Timer = null
@export var interval : float = 1.0

var playerPositions := []

func _ready() -> void:
	timer.wait_time = interval


func _on_interval_timeout() -> void:
	playerPositions.append(player.global_position)
	var snapshot := Sprite2D.new()
	var sprite_child := player.get_node_or_null("Sprite2D")

	if sprite_child:
		snapshot.texture = sprite_child.texture
		snapshot.flip_h = sprite_child.flip_h
		snapshot.global_position = player.global_position
		snapshot.scale = sprite_child.scale
		snapshot.modulate = Color(1, 1, 1, 0.3)# transparent so it looks ghostly

	get_tree().current_scene.add_child(snapshot)
	playerPositions.append(snapshot.global_position)
