extends Control
class_name MainMenu

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

const save_location = "user://leek.json"

var contents : Dictionary = {
	'current_level' : "level_1"
}

func _ready() -> void:
	# TODO : Load save file
	pass
	

func _on_start_game_pressed() -> void:
	if GameManager.current_level != null:# If saved already in a level
		GameManager.load_level(GameManager.current_level)
	else:
		animation_player.play("Main -> LevelSelect")
		AudioSystem.play_sound("ui_click")

func _on_settings_pressed() -> void:
	animation_player.play("Main -> Settings")
	AudioSystem.play_sound("ui_click")

func _on_quit_game_pressed() -> void:
	SavingSystem.save()
	get_tree().quit()

func back_from_level_select_menu() -> void:
	AudioSystem.play_sound("ui_click")
	animation_player.play_sound("Main -> LevelSelect",-1, -1, true)

func back_from_settings_menu():
	AudioSystem.play_sound("ui_click")
	animation_player.play("Main -> Settings", -1, -1, true)
