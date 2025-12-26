extends Button

@onready var audio_stream_player_2d: AudioStreamPlayer = $AudioStreamPlayer2D



func _on_pressed() -> void:
	audio_stream_player_2d.play()
