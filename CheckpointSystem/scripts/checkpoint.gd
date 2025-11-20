extends Area2D
class_name Checkpoint

## PLEASE FOR THE LOVE OF GOD; DO NOT PUT CHECKPOINTS UNDER ANY OTHER PARENT THAN THE CHECKPOINT **MANAGER**
## basically, there are three parties in the checkpoint system
## 1. Checkpoint system (global, for integration with other systems)
## 2. Checkpoint Manager (stores local checkpoints, i.e those in the level
## 3. Checkpoint object (the checkpoint that collides)

@export var can_be_recaptured : bool = true # If you can go back and reclaim it.
@export var player_layer : int = 2 # Physics layer that the player is on

var checkpoint_manager : CheckpointManager = null
var has_been_captured = false

signal checkpoint_triggered

var id := 0

func _ready() -> void:
	# Configure collision layers
	collision_layer = 0
	collision_mask = player_layer
	
	# Connect signal
	body_entered.connect(_on_player_enter)
	
	# Retrieve checkpoint manager
	var parent = get_parent()
	if parent.is_in_group("checkpoint_manager"):
		checkpoint_manager = parent
	else:
		push_error("FUCK YOU I TOLD YOU NOT TO PARENT IT TO SOMETHING ELSE YOU")
		var a = null
		a.kill()

func _on_player_enter(_body) -> void:
	# Trigger checkpoint if it can be captured
	if !can_be_recaptured:
		if !has_been_captured:
			_on_checkpoint_triggered()
			has_been_captured = true
	else:
		_on_checkpoint_triggered()

func _on_checkpoint_triggered():
	# Emit signal and update manager
	checkpoint_triggered.emit() # might be useless idk, 
	checkpoint_manager.update_checkpoint(self)
