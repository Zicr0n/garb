extends Node
class_name InputComponent

var _x_axis = 0

func _process(delta: float) -> void:
	_x_axis = Input.get_axis("move_left", "move_right")

func move_dir_x() -> float :
	return _x_axis

func is_jump_just_pressed() -> bool:
	return Input.is_action_just_pressed("jump")
