extends Area2D

signal pressed
signal open_silently

@export var manager_index = 0
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	collision_shape_2d.disabled = false
	if Level1Manager.activated_buttons.has(manager_index):
		alreadyDone()

func _on_body_entered(_body):
	press()

func press() -> void:
	#anim_player.play("button_pressed")# skapa denna animation
	collision_shape_2d.disabled = true
	collision_shape_2d.set_deferred("disabled", true)
	pressed.emit()
	Level1Manager.activated_buttons.append(manager_index)

func alreadyDone():
	collision_shape_2d.disabled = true
	collision_shape_2d.set_deferred("disabled", true)
	open_silently.emit()
	#anim_player.play("button_pressed")
