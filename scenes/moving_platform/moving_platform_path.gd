extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var timer: Timer = $Timer

var percentage_per_point
var next_percentage = 0.0
var current_point = 0
@export var SPEED : float = 100.0

func _ready() -> void:
	var points = curve.point_count
	percentage_per_point = 1.0 / (points - 1) if points > 1 else 1.0
	next_percentage = percentage_per_point

func _process(delta: float) -> void:
	if timer.time_left > 0:
		return

	var prev_ratio = path_follow_2d.progress_ratio
	path_follow_2d.progress += delta * SPEED

	# --- If ratio wrapped past 1.0 to 0.0 ---
	if path_follow_2d.progress_ratio < prev_ratio:
		# Soft reset
		current_point = 0
		next_percentage = percentage_per_point

	# --- Check if we've reached the next control point ---
	if path_follow_2d.progress_ratio >= next_percentage:
		timer.start()

		current_point += 1

		if current_point < curve.point_count:
			next_percentage += percentage_per_point
