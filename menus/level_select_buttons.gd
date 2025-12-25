extends Control

@export var main_menu : MainMenu = null
@export var level_1 = null

func _ready() -> void:
	# TODO Get from save file which levels are unlocked
	# TODO Check if player was already in a level, then load from last checkpoint
	pass

func _on_level_1_pressed() -> void:
	GameManager.load_level("level1")


func _on_level_2_pressed() -> void:
	GameManager.load_level("level2")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://yank_test_map.tscn")


func _on_back_button_pressed() -> void:
	main_menu.back_from_level_select_menu()
