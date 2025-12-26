extends Node

var dimmer : Dimmer = preload("res://GameManagement/dimmer.tscn").instantiate()
var level_system : LevelSystem = preload("res://LevelSystem/levelsystem.tscn").instantiate()
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
	add_child(level_system)
	
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
	var scene = levels[sceneName]
	
	if level_system.is_level_locked(sceneName):
		print("locked")
		return
	
	await dimmer.dim()

	if scene:
		get_tree().change_scene_to_file(scene)
		level_system.set_current_level(sceneName)
		await get_tree().process_frame
		
		current_level = sceneName
		SavingSystem.update_data("current_level_name", current_level)
		SavingSystem.save()
		current_deaths = 0
		
		# TODO : Check if there was a checkpoint in save, load player into that checkpoint
		
	else:
		push_error("SCENE NOT FOUND!!!!!!!!!!! THE END IS NEAR!!!!!!!")
	
	dimmer.brighten()

func return_to_main_menu():
	await dimmer.dim()
	
	# TODO Save Checkpoint
	
	if winscreen_instance : winscreen_instance.queue_free()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
	
	await get_tree().process_frame
	
	dimmer.brighten()

func reload_current_level():
	get_tree().reload_current_scene()
	
	# Sometiems the scene doesnt load instantly, so wait for the scene to run its first frame
	await get_tree().process_frame  # Wait for scene to fully reload (fuck you chatgpt)

func on_level_ended():
	# Get time
	var timeToComplete = gameTime
	
	# Get deaths
	var totalDeaths = current_deaths
	
	# Unlock next level
	level_system.unlock_next_level()
	
	# Return to level select screen
	level_system.set_current_level("")
	
	# Save
	current_level = null
	SavingSystem.update_data("current_level_name", current_level)
	SavingSystem.save()
	
	await dimmer.dim()
	# Show that the level was unlocked
	winscreen_instance = win_screen.instantiate()

	winscreen_instance.set_deaths(totalDeaths)
	winscreen_instance.set_time(str(timeToComplete))
	add_child(winscreen_instance)
	
	dimmer.brighten()

###########
## PAUSE ##
###########

func pause_game():
	get_tree().paused = true

func unpause_game():
	get_tree().paused = false
