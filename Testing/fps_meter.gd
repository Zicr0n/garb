extends CanvasLayer

@export var label : Label = null


func _process(delta: float) -> void:
	label.text = str(Engine.get_frames_per_second()) + 'FPS'
