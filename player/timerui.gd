extends Control

@onready var label: Label = $Label

func _process(delta: float) -> void:
	var time = GameManager.gameTime
	if time != null:
		label.text = seconds2hhmmss(time)

# https://forum.godotengine.org/t/formatting-a-timer/6482/3
func seconds2hhmmss(total_seconds: float) -> String:
	#total_seconds = 12345
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	var hhmmss_string:String = "%02d:%05.2f" % [ minutes, seconds]
	return hhmmss_string
