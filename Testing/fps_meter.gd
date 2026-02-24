extends CanvasLayer

@export var label : Label = null
var timeArray = []
var framerateArray = []
var cur_time = 0
var counted_time = 0
var total_test_time = 30

var config : ConfigFile = null

func _ready():
	config = SavingSystem.config_file

func _process(delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	if counted_time <= 0.0:
		counted_time = 1.0
		timeArray.append(cur_time)
		framerateArray.append(fps)
	
	cur_time += delta
	counted_time -= delta
	
	if cur_time >= total_test_time:
		config.set_value("FramerateTesting", "FPS", framerateArray)
		config.set_value("FramerateTesting", "TIME", timeArray)
		SavingSystem.save_config()
		get_tree().quit()
	
	label.text = str(fps) + 'FPS'
