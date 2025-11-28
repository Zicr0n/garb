extends Area2D

signal pressed
var button_pressed = false

# Denna scen ska man koppla med en @export till en annan nod som ska aktiveras. Kan vara dörr eller annat.

func _on_body_entered(_body):
	press()

func press() -> void:
	#anim_player.play("button_pressed")# skapa denna animation
	button_pressed = true
	pressed.emit()
