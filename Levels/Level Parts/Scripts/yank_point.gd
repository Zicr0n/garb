extends Area2D
class_name YankPoint

@export var timer : Timer = null
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var player : CharacterBody2D = null
var radius : float = 139.0

var active : bool = true

func yanked():
	active = false
	#animate

func _ready() -> void:
	radius = collision_shape_2d.shape.radius

func _on_yank_point_cooldown_timeout() -> void:
	active = true
