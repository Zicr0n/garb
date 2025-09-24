@icon("res://pear.svg")
extends Node
class_name PlayerStateMachine

var character = null
@export var call_input : bool = false
@export var start_state : PlayerState = null
var current_state : PlayerState = null
var previous_state : PlayerState = null

@onready var currentstateLabel: Label = $"../currentstate"
@export var input_component : InputComponent = null
@export var move_component : PlayerMoveComponent = null

func _ready():
	init(character)

func init(set_parent):
	character = set_parent
	
	if start_state == null:
		print("NO START STATE FOUND")
		return
	
	for child in get_children():
		if child is PlayerState:
			var state : PlayerState = child
			state.state_machine = self
	
	set_state(start_state)

func set_state(new_state : PlayerState):
	if current_state:
		current_state.exit()
		previous_state = current_state
	
	current_state = new_state
	current_state.enter()
	

func _input(event):
	if call_input:
		if current_state:
			var new_state : PlayerState = current_state.input(event)
			
			if new_state != null:
				# Returned a state, change to it
				set_state(new_state)

func _process(delta):
	if current_state:
		var new_state : PlayerState = current_state.process(delta)
		
		if new_state != null:
			# Returned a state, change to it
			set_state(new_state)
	
	currentstateLabel.text = current_state.name

func _physics_process(delta):
	if current_state:
		var new_state : PlayerState = current_state.physics_process(delta)
		
		if new_state != null:
			# Returned a state, change to it
			set_state(new_state)
