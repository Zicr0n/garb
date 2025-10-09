extends Area2D
class_name Hurtbox

@export var  hitboxLayer := 64
@export var  hurtboxLayer := 32

signal on_hitbox_entered(hitbox)

func _init():
	collision_layer = hurtboxLayer
	collision_mask = hitboxLayer
	
	area_entered.connect(on_hitbox)

func on_hitbox(hitbox):
	on_hitbox_entered.emit(hitbox)
