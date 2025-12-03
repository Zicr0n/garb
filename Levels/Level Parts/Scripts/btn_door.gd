extends AnimatableBody2D

@export var button : Area2D = null
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	collision_shape_2d.disabled = false
	button.pressed.connect(activate)

func activate() -> void:
	collision_shape_2d.disabled = true
	collision_shape_2d.set_deferred("disabled", true)
	
