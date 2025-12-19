extends Button
class_name KeybindHolder

var my_key = null

func _process(_delta: float) -> void:
	if my_key:
		var txt = OS.get_keycode_string(my_key)
		text = str(txt)
