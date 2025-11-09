extends Control

signal dialogue_finished

@export var dialogue : Array[String] = []
@export var text_label : Label = null
@export var next_label : Label = null

var current_line : String = ""
var shown_text : String = ""

var i : int = 0
var ii : int = 0

var letter_delay := 0.03
var letter_timer := 0.0

func _ready() -> void:
	next_label.visible = false
	change_line_to()

func _process(delta) -> void:
	letter_timer += delta
	if letter_timer >= letter_delay:
		add_letter()
		letter_timer = 0.0

	if Input.is_action_just_pressed("jump"):
		shown_text = current_line
		i = current_line.length()

	if next_label.visible and Input.is_action_just_pressed("jump"):
		next_line()

	text_label.text = shown_text

func add_letter() -> void:
	if i >= current_line.length():
		next_label.visible = true
		return
	
	var new_letter = current_line[i]
	shown_text += new_letter
	i += 1

func next_line() -> void:
	ii += 1
	change_line_to()
	next_label.visible = false

func change_line_to() -> void:
	if ii < dialogue.size():
		current_line = dialogue[ii]
		empty_box()
	else:
		dialogue_finished.emit()
		get_tree().root.queue_free()

func empty_box() -> void:
	shown_text = ""
	i = 0
