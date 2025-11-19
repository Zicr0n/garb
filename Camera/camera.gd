extends Camera2D

@export var follow_speed := 100
@export var look_ahead_distance := 40
@export var shake_intensity := 2
@export var shake_duration := 0.2
@export var player : CharacterBody2D = null
@export var initial_room : Area2D = null
var current_room : Area2D

var target_pos := Vector2.ZERO
var lookahead = false

func _ready() -> void:
	current_room = initial_room
	set_new_boundaries()

func _process(_delta):
	if player and lookahead:
		var look_ahead = sign(player.velocity.x) * look_ahead_distance
		target_pos = Vector2(player.global_position.x + look_ahead, player.global_position.y)
		global_position = global_position.move_toward(target_pos,  1000)

func shake() -> void:
	var original_pos = position
	var shake_count := 10

	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)

	for i in shake_count:
		var tween_offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		tween.tween_property(self, "position", original_pos + tween_offset, shake_duration / shake_count)
	tween.start()

func set_new_boundaries() -> void:
	limit_top = current_room.global_position.y - (current_room.box.shape.size.y / 2)
	limit_left = current_room.global_position.x - (current_room.box.shape.size.x / 2)
	limit_right = current_room.global_position.x + (current_room.box.shape.size.x / 2)
	limit_bottom = current_room.global_position.y + (current_room.box.shape.size.y / 2)

func remove_boundaries() -> void:
	limit_top = -10000000
	limit_left = -10000000
	limit_right = 10000000
	limit_bottom = 10000000

func follow_player() -> void:
	remove_boundaries()
	global_position = player.global_position

func _on_player_detect_body_exited(body: Node2D) -> void:
	if body.name == "player":
		follow_player()



func _on_room_detect_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Room"):
		current_room = area
		set_new_boundaries()
