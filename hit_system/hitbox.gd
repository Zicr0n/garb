extends Area2D
class_name Hitbox

@export var  hitboxLayer := 64
@export var  hurtboxLayer := 32

@export var damage := 10.0

signal on_hurtbox_entered(hitbox)

func _init():
	collision_layer = hitboxLayer
	collision_mask = hurtboxLayer
	
	area_entered.connect(on_hurtbox)

func on_hurtbox(hurtbox : Hitbox):
	on_hurtbox_entered.emit(hurtbox)
