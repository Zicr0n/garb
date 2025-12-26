extends CanvasLayer
class_name WinScreen

@export var deaths: Label = null
@export var time: Label = null

func set_time(timeFormat : String):
	time.text = timeFormat

func set_deaths(deathCount : int):
	deaths.text = str(deathCount)

func _on_main_menu_pressed() -> void:
	GameManager.return_to_main_menu()
