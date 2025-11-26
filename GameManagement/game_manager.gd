extends Node

var dimmer : Dimmer = preload("res://GameManagement/dimmer.tscn").instantiate()
var processing_death = false

@export var levels = {
	"level1" : "res://Levels/level_1.tscn"
}

func _ready() -> void:
	add_child(dimmer)
	dimmer.visible = false

## TODO - Make screen go dim (cool transition perhaps), reload scene, reposition at correct checkpoint, brighten screen again
func player_died(_player : Player):
	if processing_death:
		return
	
	# Dim screen
	processing_death = true
	await dimmer.dim()
	
	# Save the checkpoint position and just remove the manager
	var deathCheckpoint : Checkpoint = CheckpointSystem.get_current_checkpoint()
	
	# If no checkpoint just skip to reloading
	if !deathCheckpoint:
		print("no checkpoint")
		await reload_current_level()
		dimmer.brighten()
		return
	
	# Declare position
	var position = deathCheckpoint.global_position
	
	# Reload scene
	await reload_current_level()
	
	# Set player at correct checkpoint
	var player : Player = get_tree().get_first_node_in_group("player")

	if player:
		player.global_position = position
		print("playetrois")
	else:
		push_error("PLAYER SOMEHOW NOT FOUND!!! MAYDAY MAYDAY!!")
	
	# Brighten up buddy
	dimmer.brighten()
	processing_death = false

func load_level(sceneName):
	var scene = levels[sceneName]
	
	if scene:
		get_tree().change_scene_to_file(scene)
	else:
		push_error("SCENE NOT FOUND!!!!!!!!!!! THE END IS NEAR!!!!!!!")

func reload_current_level():
	get_tree().reload_current_scene()
	
	# Sometiems the scene doesnt load instantly, so wait for the scene to run its first frame
	await get_tree().process_frame  # Wait for scene to fully reload (fuck you chatgpt)
