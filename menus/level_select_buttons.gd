extends Control

@export var main_menu : MainMenu = null

func _on_level_1_pressed() -> void:
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	main_menu.back_from_level_select_menu()
