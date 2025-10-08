extends Control

@export var main_menu : MainMenu = null
@export var level_1 = null

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://test-scene.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://test1/scene.tscn")


func _on_back_button_pressed() -> void:
	main_menu.back_from_level_select_menu()
