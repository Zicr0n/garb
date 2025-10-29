extends Node

@export var initial_level : String
@export var camera_node : Camera2D

var current_level
var last_level


func load_level(new_level_directory: String) -> void:
	last_level = current_level
	current_level = new_level_directory

	camera_node.limit_left = current_level.limit_left
	camera_node.limit_right = current_level.limit_right
	camera_node.limit_top = current_level.limit_top
	camera_node.limit_bottom = current_level.limit_bottom
	camera_node.locked = current_level.camera_locked
	#move camera to new start position + window-wide fade/flash
