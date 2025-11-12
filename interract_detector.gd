extends Area2D
class_name Interactor

var interract_area : InteractArea = null

signal on_interaction_finished

func _init() -> void:
	collision_mask = 128

func interact() -> bool:
	if interract_area:
		interract_area.activate()
		return true
	
	return false

func _on_area_entered(area: Area2D) -> void:
	interract_area = area
	# Connect to interaction area signals
	print(area.name)
	interract_area.on_interaction_finished.connect(on_ended_interaction)

func _on_area_exited(area: Area2D) -> void:
	if area.name == interract_area.name:
		interract_area.on_interaction_finished.disconnect(on_ended_interaction)
		
		interract_area = null
		print(area.name)

func on_entered_interaction():
	print("interaction initiated")

func on_ended_interaction():
	print("interaction terminated")
	on_interaction_finished.emit()
