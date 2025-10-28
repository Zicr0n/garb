extends Node

@export var initial_level : String
@export var camera_node : Camera2D

var current_level
var last_level

func on_new_level_enter() -> void:
	pass
	#get all this from the new level and put into camera
	#Camera2D.limit_left
	#Camera2D.limit_right
	#Camera2D.limit_top
	#Camera2D.limit_bottom
	#move camera to new start position + window-wide fade/flash

func change_level_to(new_level_directory: String) -> void:
	last_level = current_level
	current_level = new_level_directory
	
	last_level.exit()
	current_level.enter()
