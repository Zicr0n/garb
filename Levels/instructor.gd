extends Area2D

@export var instruction : String = "side"

func _ready() -> void:
	await wait(1)
	body_entered.connect(on_enter)

func on_enter(bd):
	print("entered faggot")
	if bd.is_in_group("player"):
		var player : Player = bd
		player.trigger_instruction(instruction)
		queue_free()

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
