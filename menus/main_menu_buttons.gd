extends Control
class_name MainMenu

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_start_game_button_down() -> void:
	if false:
		pass # do that
	else:
		animation_player.play("Main -> LevelSelect")

func _on_settings_button_down() -> void:
	animation_player.play("Main -> Settings")

func _on_quit_game_button_down() -> void:
	get_tree().quit()

func back_from_level_select_menu() -> void:
	animation_player.play("Main -> LevelSelect",-1, -1, true)


func back_from_settings_menu():
	animation_player.play("Main -> Settings", -1, -1, true)
