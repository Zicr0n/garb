extends Area2D
class_name Collectible

@export var animated_sprite: AnimatedSprite2D = null

@onready var shine_light: PointLight2D = $ShineLight
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var unique_key: String = str(self.get_path())

signal on_collected

var shiningTimeMin = 8.0
var shiningTimeMax = 12.0
var next_shine_time = 0.0
var time = 0.0
var move_speed = 5.0

var player : Player = null

func _ready() -> void:
	print(unique_key)

func _process(delta: float) -> void:
	time += delta
	
	if time > next_shine_time:
		next_shine_time = time + randf_range(shiningTimeMin, shiningTimeMax)
		animated_sprite.play("shine")
		
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(shine_light, "energy", 3.0, 0.3)
		
		await animated_sprite.animation_finished
		
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(shine_light, "energy", 0.0, 0.5)
		animated_sprite.play("default")
	
	if player:
		global_position =  global_position.slerp(player.global_position, delta * move_speed)
		
		if player.is_on_floor():
			# Collect self
			print("WEGHwe")
			on_collection()

func on_collection():
	player = null
	animation_player.play("collect")
	await animation_player.animation_finished
	on_collected.emit()
	hide()
	collision_shape_2d.disabled = true
	

func _on_body_entered(body: Node2D) -> void:
	# Check if player
	if body.is_in_group("player"):
		player = body
