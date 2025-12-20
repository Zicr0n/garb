extends Node

@export var sounds : Array[Sound] = []

func _ready() -> void:
	# Create AudioStreamPlayer instances of all Sound resources
	for sound : Sound in sounds:
		var audio_player_instance = AudioStreamPlayer.new()
		audio_player_instance.name = sound.name
		audio_player_instance.autoplay = sound.autoplay
		audio_player_instance.volume_db = sound.volume_db
		audio_player_instance.pitch_scale = sound.pitch
		
		# Check if there is a stream
		if sound.stream:
			audio_player_instance.stream = sound.stream
			audio_player_instance.stream.loop = sound.loop
		
		# Check validity of audio bus
		if AudioServer.get_bus_index(sound.audio_bus) != -1:
			audio_player_instance.bus = sound.audio_bus
		else:
			audio_player_instance.bus = "Master"
		
		add_child(audio_player_instance)

func get_sound_from_name(request_name : String) -> Sound:
	var target = null
	
	# Jarvis, aquire target
	for sound in sounds:
		if sound.name == request_name:
			# Hell yeah Jarvis nice work
			target = sound
			break
	
	return target

func play_sound(requested_name : String):
	# Find sound
	var sound : Sound = get_sound_from_name(requested_name)
	var player : AudioStreamPlayer = get_node(sound.name)
	
	if sound && player:
		# Pitch variance
		player.pitch_scale = sound.pitch + randf_range(-sound.pitch_variance, sound.pitch_variance)
		player.volume_db = sound.volume_db + randf_range(-sound.volume_variance, sound.volume_variance)
		
		# Play sound (duh)
		player.play()
		return
	
	print("NO SOUND WITH THAT NAME FOUND")

func stop_sound(request : String):
	# Find sound
	var sound : Sound = get_sound_from_name(request)
	var player : AudioStreamPlayer = get_node(sound.name)
	
	# Play sound (duh)
	if sound && player:
		# Get pitch variance
		player.stop()
		return
	
	print("NO SOUND WITH THAT NAME FOUND")
