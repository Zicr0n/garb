extends Area2D

signal room_area_entered(area)

func _on_area_entered(area):
	emit_signal("room_area_entered", area)
