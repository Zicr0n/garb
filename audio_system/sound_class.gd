extends Resource
class_name Sound

@export var name : String = ""
@export var stream : AudioStream = null
@export var loop : bool = false
@export var autoplay : bool = false
@export_range(0.0,3.0,0.1) var pitch : float = 1.0
@export_range(-80.0,24.0,0.1) var volume_db :  = 0.0
@export_range(0.0, 2.0, 0.1) var pitch_variance : float = 0.0
@export_range(0.0, 2.0, 0.1) var volume_variance : float = 0.0
@export var audio_bus: String = "Master"
