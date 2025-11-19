extends Node

var current_checkpoint_manager : CheckpointManager = null

func set_current_checkpoint_manager(manager : CheckpointManager):
	current_checkpoint_manager = manager

func remove_current_checkpoint_manager():
	current_checkpoint_manager = null

func get_current_checkpoint() -> Checkpoint:
	if current_checkpoint_manager:
		return current_checkpoint_manager.current_checkpoint
	
	return null
