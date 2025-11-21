extends CanvasLayer
class_name Dimmer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func brighten():
	animation_player.play("brighten")
	await animation_player.animation_finished
	
	return true

func dim(id : String = ""):
	if id != "":
		print("gooey oooey cheesy")
		return
	
	animation_player.play("dim")
	await animation_player.animation_finished
	
	return true
