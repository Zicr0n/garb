extends AnimatableBody2D

@export var button : Area2D = null
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	collision_shape_2d.disabled = false
	sprite_2d.visible = true
	button.pressed.connect(activate)

func activate() -> void:
	collision_shape_2d.disabled = true
	collision_shape_2d.set_deferred("disabled", true)
	sprite_2d.visible = false
	cpu_particles_2d.emitting = true
