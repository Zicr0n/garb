extends Area2D
class_name InteractArea

var has_interacted = false
signal on_interact
signal on_interaction_finished

@export var auto_activate : bool = false

func _init() -> void:
	collision_layer = 128

func activate() -> void:
	if has_interacted: return
	
	print("mikudayoooo")
	has_interacted = true
	on_interact.emit()
	#interracted.emit()

func end_interaction() -> void:
	has_interacted = false
	on_interaction_finished.emit()
