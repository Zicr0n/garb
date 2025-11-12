@icon("res://pear.svg")
extends Node
class_name PlayerStateMachine

@export var character : CharacterBody2D = null
@export var call_input : bool = false
@export var start_state : PlayerState = null
var current_state : PlayerState = null
var previous_state : PlayerState = null

@export var _death_state : PlayerState = null

@export var input_component : InputComponent = null
@export var move_component : PlayerMoveComponent = null
@export var health_component : HealthComponent = null

@export var disabled := false

@export var _interract_area : Area2D = null;

enum FALL_SOURCE {
	PLATFORM,
	OTHER
}

var fall_source = FALL_SOURCE.PLATFORM

func _ready():
	init(character)
	health_component.on_die.connect(func():
		set_state(_death_state))

func init(set_parent):
	character = set_parent
	move_component.characterBody2D = character
	
	if start_state == null:
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
	

func _input(event : InputEvent):
	if disabled: return
	if call_input:
		if current_state:
			var new_state : PlayerState = current_state.input(event)
			
			if new_state != null:
				# Returned a state, change to it
				set_state(new_state)

func _process(delta):
	if disabled: return
	if current_state:
		var new_state : PlayerState = current_state.process(delta)
		
		if new_state != null:
			# Returned a state, change to it
			set_state(new_state)


func _physics_process(delta):
	if disabled: return
	if current_state:
		var new_state : PlayerState = current_state.physics_process(delta)
		
		if new_state != null:
			# Returned a state, change to it
			set_state(new_state)
