extends Node
class_name HealthComponent

@export var hurtbox : Hurtbox = null

signal on_die

func _ready() -> void:
	hurtbox.on_hitbox_entered.connect(on_hit)

func on_hit(_hitbox : Hitbox):
	on_die.emit()
