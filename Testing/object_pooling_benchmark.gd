extends Node2D
class_name ObjectPool

@export var scene_to_instantiate : PackedScene = null
@export var preload_amount : int = 10
@export var parent = self
var object_pool : Array = []
var active_scenes : Array = []


func _ready() -> void:
	for i in range(preload_amount):
		var instantiated = scene_to_instantiate.instantiate()
		add_to_pool(instantiated)
		add_child(instantiated)

func pull_from_pool() -> Node2D:
	var object : Node2D
	if object_pool.is_empty():
		object = scene_to_instantiate.instantiate()
		add_child(object)
	else:
		object = object_pool[object_pool.size()-1]
		object_pool.pop_back()
	object.set_process(true)
	object.set_physics_process(true)
	object.show()
	return object

func add_to_pool(object: Node2D) -> void:
	object_pool.append(object)
	object.set_process(false)
	object.set_physics_process(false)
	object.hide()

func kill(area2d : Area2D):
	add_to_pool(area2d)
