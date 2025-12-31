extends Node

var dimmer : Dimmer = preload("res://GameManagement/dimmer.tscn").instantiate()
var win_screen = preload("res://GameManagement/win_screen.tscn")
var processing_death = false

@export var levels = {
	"level1" : "res://Levels/level_1.tscn",
	"level2" : "res://level_building_test.tscn"
}

## TODO : Load current_level from save file
var current_level = null
var current_deaths = 0
var winscreen_instance : WinScreen = null
#
#signal level_started
#signal level_ended

var gameTime = null

func _process(delta: float) -> void:
	## TODO fix this cuz currentlevel is used for saving now
	if current_level:
		if gameTime == null:
			gameTime = 0
		else:
			gameTime += delta
	else:
		gameTime = null

func _ready() -> void:
	add_child(dimmer)
	
	SavingSystem.loaded_data.connect(
		func():
		current_level =  SavingSystem.get_data("current_level_name")
		)

func player_died(_player : Player):
	if processing_death:
		return
	
	# Dim screen
	processing_death = true
	current_deaths += 1
	
	await dimmer.dim()
	
	# Save the checkpoint position and just remove the manager
	var deathCheckpoint : Checkpoint = CheckpointSystem.get_current_checkpoint()
	
	# If no checkpoint just skip to reloading
	if !deathCheckpoint:
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
	else:
		push_error("PLAYER SOMEHOW NOT FOUND!!! MAYDAY MAYDAY!!")
	
	# Brighten up buddy
	dimmer.brighten()
	processing_death = false

func load_level(sceneName):
	print(SavingSystem.save_data)
	var scene = levels[sceneName]
	
	if Levels.is_level_locked(sceneName):
		print("locked")
		return
	
	await dimmer.dim()

	if scene:
		get_tree().change_scene_to_file(scene)
		Levels.set_current_level(sceneName)
		await get_tree().process_frame
		
		current_level = sceneName
		
		SavingSystem.update_data("current_level_name", current_level)
		
		current_deaths = 0
		
		# TODO : Check if there was a checkpoint in save, load player into that checkpoint
		var checkpoint_index = SavingSystem.get_data("last_checkpoint_index")
		
		if checkpoint_index != -1:
			var last_checkpoint : Checkpoint = CheckpointSystem.get_checkpoint_from_index(checkpoint_index)
			
			if last_checkpoint:
				var player : Player = get_tree().get_first_node_in_group("player")
				player.global_position = last_checkpoint.global_position
		
	else:
		push_error("SCENE NOT FOUND!!!!!!!!!!! THE END IS NEAR!!!!!!!")
	
	dimmer.brighten()

func return_to_main_menu():
	await dimmer.dim()
	
	# TODO Save Checkpoint
	save_current_checkpoint()
	
	if winscreen_instance : winscreen_instance.queue_free()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
	
	await get_tree().process_frame
	
	dimmer.brighten()

func reload_current_level():
	get_tree().reload_current_scene()
	
	# Sometiems the scene doesnt load instantly, so wait for the scene to run its first frame
	await get_tree().process_frame  # Wait for scene to fully reload (fuck you chatgpt)

func load_scene(path):
	await dimmer.dim()
	get_tree().change_scene_to_file(path)
	dimmer.brighten()

func on_level_ended():
	# Get time
	var timeToComplete = gameTime
	
	# Get deaths
	var totalDeaths = current_deaths
	
	# Unlock next level
	Levels.unlock_next_level()
	
	# Return to level select screen
	Levels.set_current_level("")
	
	# Save
	current_level = null
	CheckpointSystem.latestCheckpointId = null
	
	SavingSystem.update_data("current_level_name", current_level)
	SavingSystem.update_data("last_checkpoint_index", -1)
	SavingSystem.save()
	
	await dimmer.dim()
	# Show that the level was unlocked
	winscreen_instance = win_screen.instantiate()

	winscreen_instance.set_deaths(totalDeaths)
	winscreen_instance.set_time(str(timeToComplete))
	add_child(winscreen_instance)
	
	dimmer.brighten()

func save_current_checkpoint():
	var last_checkpoint : Checkpoint = CheckpointSystem.get_current_checkpoint()
	if last_checkpoint:
		SavingSystem.update_data("last_checkpoint_index", last_checkpoint.id)
		SavingSystem.save()

###########
## PAUSE ##
###########

func pause_game():
	get_tree().paused = true

func unpause_game():
	get_tree().paused = false
