extends Node2D
class_name BenchMark
		  
@export var scene_to_instantiate : PackedScene = null
@export var preload_amount : int = 10
@export var parent = self
var active_scenes : Array = []

func _ready() -> void:
	print("hello world")

func create_object() -> Node2D:
	return scene_to_instantiate.instantiate()

func kill(area2d : Area2D):
	area2d.queue_free()
