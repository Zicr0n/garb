extends Node

signal dim_screen

@export var levels = {
	"level1" : "res://Levels/level_1.tscn"
}

## TODO - Make screen go dim (cool transition perhaps), reload scene, reposition at correct checkpoint, brighten screen again
func player_died(_player : Player):
	print("boohoo noob")
	dim_screen.emit()

func load_level(sceneName):
	var scene = levels[sceneName]
	
	if scene:
		get_tree().change_scene_to_file(scene)
	else:
		push_error("SCENE NOT FOUND!!!!!!!!!!!")
