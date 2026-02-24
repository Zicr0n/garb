extends Node

@export var object_pooling_benchmark : ObjectPool = null
@export var speed : Vector2 = Vector2.ZERO

@export_range(0.0, 10.0, 0.00001) var cooldown : float = 1.0
var timer : float = 0.0

var shot_rate: float = 1/3000. #3000 shots a second
var idle_time = 10
var cur_time = 0

func _process(delta: float) -> void:
	if cur_time > idle_time:
		timer -= delta
		while timer < 0:
			timer += shot_rate
			new_object()
	else:
		cur_time += delta

func new_object() -> void:
	var object = object_pooling_benchmark.pull_from_pool()
	object.global_position = Vector2(100, randf_range(10,310))
	object.speed = speed
	object.benchmark_node = object_pooling_benchmark
