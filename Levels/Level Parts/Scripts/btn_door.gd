extends StaticBody2D

@export var button : Area2D = null

func _ready() -> void:
	$CollisionShape2D.disabled = false
	button.pressed.connect(activate)

func activate() -> void:
	$CollisionShape2D.disabled = true
