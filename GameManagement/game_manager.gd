extends Node

signal dim_screen

## TODO - Make screen go dim (cool transition perhaps), reload scene, reposition at correct checkpoint, brighten screen again
func player_died(_player : Player):
	print("boohoo noob")
	dim_screen.emit()
