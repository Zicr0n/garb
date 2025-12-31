extends CanvasLayer

var visibleLabels : Array[String] = []

@export var spritepos = Vector2(0, 100)

var actions := {
	"MoveLeftLabel": "move_left",
	"MoveRightLabel": "move_right",
	"JumpLabel": "jump",
	"DashLabel": "dash",
	"YankLabel": "grapple"
}

func _ready():
	$VBoxContainer/MoveLeftLabel.text = "Move Left"
	$VBoxContainer/MoveRightLabel.text = "Move Right"
	$VBoxContainer/JumpLabel.text = "Jump"
	$VBoxContainer/DashLabel.text = "Dash"
	$VBoxContainer/YankLabel.text = "Grapple"

	$VBoxContainer/MoveLeftLabel/Sprite2D.offset = spritepos
	$VBoxContainer/MoveRightLabel/Sprite2D.offset = spritepos
	$VBoxContainer/JumpLabel/Sprite2D.offset = spritepos
	$VBoxContainer/DashLabel/Sprite2D.offset = spritepos
	$VBoxContainer/YankLabel/Sprite2D.offset = spritepos

	update_label_sprites()

func get_action_keys(action_name: String) -> String:
	var events = InputMap.action_get_events(action_name)
	var keys := []

	for event in events:
		if event is InputEventKey:
			keys.append(event.as_text())

	if keys.size() > 0:
		return keys[0]
	else:
		return ""

func update_label_sprites() -> void:
	for label in $VBoxContainer.get_children():
		set_key_sprite(label.get_child(0), get_action_keys(actions[label.name]))

func set_key_sprite(sprite2D, key_name: String):
	if key_name == "":
		return
	key_name = String(key_name).to_lower()
	var atlas := AtlasTexture.new()
	atlas.atlas = preload("res://Assets/FREE/KeyBinds/Keyboard Letters and Symbols.png")
	print(key_name)
	atlas.region = KeySpriteGlob.coordsblue[key_name]
	sprite2D.texture = atlas
