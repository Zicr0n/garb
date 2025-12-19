extends Control

@export var main_menu : MainMenu = null


func _on_back_button_pressed() -> void:
	main_menu.back_from_settings_menu()


func _on_extra_spice_toggled(toggled_on: bool) -> void:
	pass # Ändra status i game manager

func _on_button_pressed() -> void:
	main_menu.back_from_settings_menu()
