extends Area2D

signal pressed

# Denna scen ska man koppla med en @export till en annan nod som ska aktiveras. Kan vara dörr eller annat.

func _ready() -> void:
	$CollisionShape2D.disabled = false

func _on_body_entered(_body):
	press()

func press() -> void:
	#anim_player.play("button_pressed")# skapa denna animation
	$CollisionShape2D.disabled = true
	pressed.emit()
