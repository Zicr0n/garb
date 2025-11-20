extends Node

var current_checkpoint_manager : CheckpointManager = null
var not_recapturable : Array[int] = []

var latestCheckpointId = null

func set_current_checkpoint_manager(manager : CheckpointManager):
	current_checkpoint_manager = manager

func remove_current_checkpoint_manager():
	current_checkpoint_manager = null

func get_current_checkpoint() -> Checkpoint:
	if current_checkpoint_manager:
		return current_checkpoint_manager.current_checkpoint
	
	return null

func add_captured_checkpoint(id : int):
	not_recapturable.append(id)

func is_in_non_recaptures(id):
	if not_recapturable.has(id):
		return true
	
	return false
