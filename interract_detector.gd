extends Area2D

signal dialogue_finished

var interract_area = null

func _init() -> void:
	collision_mask = 128

func end_interaction():
	dialogue_finished.emit()

func _on_area_entered(area: Area2D) -> void:
	interract_area = area

func _on_area_exited(area: Area2D) -> void:
	if area.name == interract_area.name:
		interract_area = null
