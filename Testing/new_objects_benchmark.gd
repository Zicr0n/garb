extends Node2D
class_name BenchMark

@export var scene_to_instantiate : PackedScene = null
@export var preload_amount : int = 10
@export var parent = self
var background_pool = []
var current_pool = []

func _ready() -> void:
	for i in range(preload_amount):
		var instantiated = scene_to_instantiate.instantiate()
		instantiated.process_mode = Node.PROCESS_MODE_DISABLED
		instantiated.set_physics_process(false)
		instantiated.global_position = Vector2(randf_range(0,640), 30)
		#instantiated.hidden = true
		parent.add_child(instantiated)
		background_pool.append(instantiated)

func callObject(index):
	pass
