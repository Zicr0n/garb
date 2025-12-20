extends VBoxContainer

@export var master_volume_slider : SettingSlider = null
@export var sfx_volume_slider : SettingSlider = null
@export var music_volume_slider : SettingSlider = null

@export var full_screen_toggle : SettingToggle = null
@export var start_control : Control = null

func _ready() -> void:
	master_volume_slider.value_changed.connect(set_master_volume)
	sfx_volume_slider.value_changed.connect(set_sfx_volume)
	music_volume_slider.value_changed.connect(set_music_volume)
	
	full_screen_toggle.value_changed.connect(toggle_fullscreen)
	
	if start_control:
		start_control.grab_focus.call_deferred()

func toggle_fullscreen(val):
	if val == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func set_master_volume(newVal):
	var index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(index, newVal)

func set_sfx_volume(newVal):
	var index = AudioServer.get_bus_index("Sfx")
	AudioServer.set_bus_volume_linear(index, newVal)

func set_music_volume(newVal):
	var index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(index, newVal)
