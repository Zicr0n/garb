extends Area2D
class_name InteractArea

signal interracted
signal finished_interaction

func _init() -> void:
	collision_layer = 128

func activate() -> void:
	interracted.emit()

func ended() -> void:
	finished_interaction.emit()
