extends PathFollow2D

# On PathFollow2D
@export var speed := 50.0
var direction = 1
var ratio = 0
var waiting = true

@onready var timer : Timer = Timer.new()

func _ready() -> void:
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = 1.0
	add_child(timer)

func _process(delta):
	if timer.time_left > 0: return
	
	ratio += speed * direction * delta / get_parent().curve.get_baked_length()
	
	if ratio > 1:
		direction *= -1
		ratio = 1
		timer.start()
	elif ratio <= 0.0:
		direction *= -1
		ratio = 0
		timer.start()
	
	progress_ratio = ratio
