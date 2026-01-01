extends Node

const save_location = "user://leeks.json"

var save_data : Dictionary = {
	"current_level_name" : null, 
	"last_checkpoint_index" : -1,
	"levels" : {}
}

var settings_directory = "user://user_settings.miku"

var config_file : ConfigFile = null

signal loaded_data

func _init():
	config_file = ConfigFile.new()
	
	var error = config_file.load(settings_directory)
	
	if error != OK:
		return

func save_config():
	if config_file:
		config_file.save(settings_directory)

func _ready() -> void:
	_load_data()

func update_data(key, value):
	if save_data.has(key):
		save_data[key] = value

func get_data(key):
	if save_data.has(key):
		return save_data[key]

func save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(save_data.duplicate())
	file.close()

func _load_data():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		for keys in save_data.keys():
			if data.has(keys):
				save_data[keys] = data[keys]
		
		loaded_data.emit()
