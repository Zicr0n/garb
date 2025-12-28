extends Node
class_name LevelSystem

var levels : Array[Level]= []

var current_level : Level = null

var data_to_save = {"collectibles" : []}

func _ready() -> void:
	for i in range(get_children().size()):
		var child = get_child(i)
		if child is Level:
			levels.append(child)

func is_level_locked(levelName) -> bool:
	for lvl in levels:
		if lvl.levelName == levelName:
			if lvl.unlocked:
				return false
	
	return true 

func set_current_level(lvlName : String):
	var level : Level = null
	
	if lvlName == "":
		current_level = null
		return
	
	for lvl in levels:
		if lvl.levelName == lvlName:
			level = lvl
			break
	
	if level == null:
		push_error("NOT FOUND LEVEL")
		return
	
	current_level = level
	
	var levels_data : Dictionary = SavingSystem.get_data("levels").duplicate()
	
	if levels_data.has(level.id):
		print(levels_data[level.id])
	else:
		levels_data[level.id] = data_to_save
	
	SavingSystem.update_data("levels", levels_data)

func unlock_next_level():
	if current_level == null:
		return
	
	var current_index = levels.find(current_level)
	var next_index = current_index + 1;
	
	if next_index > levels.size() - 1:
		push_error("ERROR! OUTSIDE OF RANGE")
		return
	
	var next_level = levels[next_index]
	next_level.unlocked = true

func on_collectible_collected(index):
	if index != null && current_level != null:
		var levels_data : Dictionary = SavingSystem.get_data("levels").duplicate()
		var collectibles_array : Array = levels_data[current_level.id]["collectibles"]
		
		collectibles_array.append(index)
		
		SavingSystem.update_data("levels", levels_data)
		SavingSystem.save()
	
	print(SavingSystem.save_data)

func get_saved_collectibles() -> Array:
	if current_level:
		return SavingSystem.get_data("levels")[current_level.id]["collectibles"]
	
	return []
