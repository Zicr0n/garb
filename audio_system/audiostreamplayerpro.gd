extends AudioStreamPlayer
class_name AudioStreamPlayerPro

func _init() -> void:
	finished.connect(stream_finished)

func stream_finished():
	print("I am done!")
