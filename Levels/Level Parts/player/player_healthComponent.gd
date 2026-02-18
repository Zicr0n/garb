extends Node
class_name HealthComponent

@export var hurtbox : Hurtbox = null

signal on_die

var last_hitter = null

func _ready() -> void:
	hurtbox.on_hitbox_entered.connect(on_hit)

func on_hit(hitbox : Hitbox):
	last_hitter = hitbox
	on_die.emit()
