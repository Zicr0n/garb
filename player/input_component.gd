extends Node
class_name InputComponent

var _x_axis = 0

func _process(_delta: float) -> void:
	_x_axis = Input.get_axis("move_left", "move_right")

func move_dir_x() -> float :
	return _x_axis

func move_down() -> bool:
	return Input.is_action_pressed("move_down")

func is_jump_just_pressed() -> bool:
	return Input.is_action_just_pressed("jump")

func is_yank_just_pressed() -> bool:
	return Input.is_action_just_pressed("grapple")

func is_dash_just_pressed() -> bool:
	return Input.is_action_just_pressed("dash")

func aim_dash() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
