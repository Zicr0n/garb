extends Camera2D

@export var follow_speed := 100
@export var look_ahead_distance := 40
@export var shake_intensity := 2
@export var shake_duration := 0.2
@export var snap_duration := 1.0
@export var player : CharacterBody2D = null
@export var initial_room : Area2D = null
var current_room : Area2D

var target_pos := Vector2.ZERO
var lookahead = false
var tween : Tween

func _ready() -> void:
	current_room = initial_room
	#snap_to_room(current_room, true)
	player.get_node("RoomDetect").room_area_entered.connect(_on_player_detector_area_entered)

func _process(_delta):
	if player and lookahead:
		var look_ahead = sign(player.velocity.x) * look_ahead_distance
		target_pos = Vector2(player.global_position.x + look_ahead, player.global_position.y)
		global_position = global_position.move_toward(target_pos,  1000)

# ----------------------------
# ROOM HANDLING
# ----------------------------

func snap_to_room(room : Area2D, instant := false) -> void:
	#var size = room.get_node("CollisionShape2D").shape.size
	#var half = size / 2
	var pos = room.global_position

	# Camera rect for this room
	#limit_left   = pos.x - half.x
	#limit_right  = pos.x + half.x
	#limit_top    = pos.y - half.y
	#limit_bottom = pos.y + half.y

	# Center the camera on the room
	var room_center = pos

	if instant or snap_duration == 0:
		global_position = room_center
	else:
		if tween:
			tween.kill()        
		tween = create_tween()
		tween.tween_property(
								self,
								"global_position",
								room_center,
								snap_duration
							).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.play()

func shake() -> void:
	var original_pos = position
	var shake_count := 10

	var shakeTween : Tween = create_tween()
	shakeTween.set_ease(Tween.EASE_OUT)
	shakeTween.set_trans(Tween.TRANS_SINE)

	for i in shake_count:
		var shakeTween_offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		shakeTween.tween_property(self, "global_position", original_pos + shakeTween_offset, shake_duration / shake_count)
	shakeTween.start()

func _on_player_detector_area_entered(area):
	if not area.is_in_group("Rooms"):
		return

	if area.name == current_room.name:
		return

	current_room = area
	snap_to_room(area, false)
