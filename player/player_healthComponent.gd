extends Node
class_name HealthComponent

@export var hurtbox : Hurtbox = null

var health = 100

signal on_die
signal on_damage(dmg)

func _ready() -> void:
	hurtbox.on_hitbox_entered.connect(on_hit)

func on_hit(hitbox : Hitbox):
	var damage = hitbox.damage
	
	health -= damage
	on_damage.emit(damage)
	
	if health <= 0:
		on_die.emit()
	
