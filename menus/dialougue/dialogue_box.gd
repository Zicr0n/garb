extends Control

@export var dialogue : Array[String] = []
@export var text_label : Label = null
@export var next_label : Label = null

var current_line : String = ""
var shown_text : String = ""
var i : int = 0
var ii : int = 0

func _ready() -> void:
	next_label.visible = false
	change_line_to(ii)

func _process(_delta) -> void:
	add_letter()

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
	i = 0
	ii += 1
	change_line_to(ii)

func change_line_to(ii) -> void:
	current_line = dialogue[ii]
