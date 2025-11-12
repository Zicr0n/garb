extends Control

@export var dialogue : Array[String] = []
@export var activation_signal_emitter : InteractArea = null
@export var text_label : Label = null
@export var next_label : Label = null

var current_line : String = ""
var shown_text : String = ""

var i : int = 0
var ii : int = 0

var letter_delay := 0.03
var letter_timer := 0.0

var active : bool = false

func activate() -> void:
	active = true
	visible = true
	change_line_to()

func _ready() -> void:
	visible = false
	next_label.visible = false
	activation_signal_emitter.on_interact.connect(activate)

func _process(delta) -> void:
	if active:
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
		exit()

func empty_box() -> void:
	shown_text = ""
	i = 0

func exit() -> void:
	#reset everything
	active = false
	visible = false
	i = 0
	ii = 0
	current_line = ""
	shown_text = ""
	
	activation_signal_emitter.end_interaction()
