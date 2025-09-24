extends Control

var continuefromlastsavemidlevel = false # temporary

func _on_start_game_button_down() -> void:
	if continuefromlastsavemidlevel:
		pass # do that
	else:
		pass #go to levelselect menu


func _on_settings_button_down() -> void:
	pass # Replace with function body.


func _on_quit_game_button_down() -> void:
	get_tree().quit()
