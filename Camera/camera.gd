extends Camera2D

@export var follow_speed := 100
@export var look_ahead_distance := 40
@export var shake_intensity := 2
@export var shake_duration := 0.2
@export var player : CharacterBody2D = null

var target_pos := Vector2.ZERO
var lookahead = false

func _process(delta):
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
