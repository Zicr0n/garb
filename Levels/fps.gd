extends Node

var title := "Game v0.1"

func _process(delta):
	DisplayServer.window_set_title(title + " | fps: " + str(Engine.get_frames_per_second()))
