extends Area2D

@export var timer : Timer = null

var player : CharacterBody2D = null

var active : bool = true

func yanked():
	active = false
	#animate

func _on_yank_point_cooldown_timeout() -> void:
	active = true
	#animate
