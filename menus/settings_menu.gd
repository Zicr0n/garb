extends Control

@export var main_menu : MainMenu = null


func _on_back_button_pressed() -> void:
	main_menu.back_from_settings_menu()


func _on_ux_improvements_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
