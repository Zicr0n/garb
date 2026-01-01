extends CanvasLayer

var visibleLabels : Array[String] = []

@export var errorkey : String = "(unset)"
@export var visibleActions : Dictionary

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

func set_key_sprite(panel, key_name: String):
	if key_name == "":
		return
	key_name = String(key_name).to_lower()
	var atlas := AtlasTexture.new()
	atlas.atlas = preload("res://Assets/FREE/KeyBinds/Keyboard Letters and Symbols.png")
	if KeySpriteGlob.coordsblue.has(key_name):
		atlas.region = KeySpriteGlob.coordsblue[key_name]
	else:
		atlas.region = KeySpriteGlob.coordsblue[errorkey]
	panel.texture = atlas
	panel.update_texture()
