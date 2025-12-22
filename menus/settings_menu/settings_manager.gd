extends VBoxContainer

@export var master_volume_slider : SettingSlider = null
@export var sfx_volume_slider : SettingSlider = null
@export var music_volume_slider : SettingSlider = null

@export var full_screen_toggle : SettingToggle = null
@export var start_control : Control = null

var config : ConfigFile = null
var settings_directory = "user://user_settings.miku"
var volume_section = "volume"
var screen_section = "screen"

func _ready() -> void:
	master_volume_slider.value_changed.connect(set_master_volume)
	sfx_volume_slider.value_changed.connect(set_sfx_volume)
	music_volume_slider.value_changed.connect(set_music_volume)
	
	full_screen_toggle.value_changed.connect(toggle_fullscreen)
	
	if start_control:
		start_control.grab_focus.call_deferred()
	
	# Saving system
	config = ConfigFile.new()
	
	# Load settings
	var error = config.load(settings_directory)
	
	if error != OK:
		return
	
	# Fullscreen
	var fullscreen = config.get_value(screen_section, "fullscreen", false)
	toggle_fullscreen(fullscreen)
	
	# Master volume
	var master_volume = config.get_value(volume_section, "master_volume", 1.0)
	set_master_volume(master_volume)
	master_volume_slider.set_value(master_volume)
	
	# Sfx volume
	var sfx_volume = config.get_value(volume_section, "sfx_volume", 1.0)
	set_sfx_volume(sfx_volume)
	sfx_volume_slider.set_value(sfx_volume)
	
	# Music volume
	var music_volume = config.get_value(volume_section, "music_volume", 1.0)
	set_music_volume(music_volume)
	music_volume_slider.set_value(music_volume)

func toggle_fullscreen(val):
	if val == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	save_setting(screen_section,"fullscreen", val)

func set_master_volume(newVal):
	if newVal == null : return
	var index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(index, newVal)
	save_setting(volume_section,"master_volume", newVal)

func set_sfx_volume(newVal):
	if newVal == null : return
	var index = AudioServer.get_bus_index("Sfx")
	AudioServer.set_bus_volume_linear(index, newVal)
	save_setting(volume_section,"sfx_volume", newVal)

func set_music_volume(newVal):
	if newVal == null : return
	var index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(index, newVal)
	save_setting(volume_section,"music_volume", newVal)

func save_setting(section, setting : String, value):
	if config:
		config.set_value(section, setting, value)
		
		config.save(settings_directory)
