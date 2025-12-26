extends Node
class_name LevelSystem

var levels : Array[Level]= []

var current_level = null

func _ready() -> void:
	for i in range(get_children().size()):
		var child = get_child(i)
		if child is Level:
			levels.append(child)
	
	print(levels)

func is_level_locked(levelName) -> bool:
	for lvl in levels:
		if lvl.levelName == levelName:
			if lvl.unlocked:
				return false
	
	return true 

func set_current_level(lvlName : String):
	var level = null
	
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
