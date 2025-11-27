extends Control
class_name MainMenu

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_start_game_pressed() -> void:
	if false:# If saved already in a level
		pass# Go directly there
	else:
		animation_player.play("Main -> LevelSelect")

func _on_settings_pressed() -> void:
	animation_player.play("Main -> Settings")

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func back_from_level_select_menu() -> void:
	animation_player.play("Main -> LevelSelect",-1, -1, true)

func back_from_settings_menu():
	animation_player.play("Main -> Settings", -1, -1, true)
