extends Panel

var texture

func update_texture() -> void:
	var box = get_theme_stylebox("panel") as StyleBoxTexture
	box.texture = texture
