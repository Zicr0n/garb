extends Node
class_name CheckpointManager

## PLEASE FOR THE LOVE OF GOD; DO NOT PUT CHECKPOINTS UNDER ANY OTHER PARENT THAN THE CHECKPOINT **MANAGER**
## basically, there are three parties in the checkpoint system
## 1. Checkpoint system (global, for integration with other systems)
## 2. Checkpoint Manager (stores local checkpoints, i.e those in the level
## 3. Checkpoint object (the checkpoint that collides)

var checkpoints : Array[Checkpoint] = []
var current_checkpoint = null

func _init():
	add_to_group("checkpoint_manager")

func _ready() -> void:
	# Declare to the system that we are currently using THIS manager and THESE checkpoints
	CheckpointSystem.set_current_checkpoint_manager(self)
	
	# Get all checkpoints and assign ID (always the same id each scene reload)
	var i := 0
	for object in get_children():
		if object is Checkpoint:
			object.id = i
			checkpoints.append(object)
			
		i += 1
	
	if CheckpointSystem.latestCheckpointId != null:
		current_checkpoint = checkpoints[CheckpointSystem.latestCheckpointId]
	
	if checkpoints.size() <= 0:
		# Just to prevent gamebreaking errors (it wont happen), a lil fix
		push_error("NO CHECKPOINTS FOUND; CREATING ONE")
		
		var checkpoint = Checkpoint.new()
		checkpoint.checkpoint_manager = self
		checkpoint.global_position = Vector2.ZERO
		add_child(checkpoint)

# Self explanatory
func update_checkpoint(checkpoint : Checkpoint):
	if checkpoints.has(checkpoint):
		var id = checkpoint.id
		if !CheckpointSystem.is_in_non_recaptures(id):
			
			if checkpoint.can_be_recaptured == false:
				CheckpointSystem.add_captured_checkpoint(id)
			
			current_checkpoint = checkpoint
			CheckpointSystem.latestCheckpointId = checkpoint.id
