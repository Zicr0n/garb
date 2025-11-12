extends Area2D

@export var player : Player = null
@export var yankArrow : Line2D = null
@export var grapple_cursor : Sprite2D = null

var yankPoints : Array[Area2D]
var nearest : Area2D = null

func _process(delta: float) -> void:
	nearestPoint()
	
	if nearest:
		grapple_cursor.global_position = nearest.global_position
		grapple_cursor.rotation += 3.14 * delta
		grapple_cursor.visible = true
# vet ej var detta ska ligga

func _on_area_entered(area: Area2D) -> void:
	if yankPoints.has(area): return
	yankPoints.append(area)
	#nearestPoint()


func _on_area_exited(area: Area2D) -> void:
	var index = yankPoints.find(area, 0);
	yankPoints.remove_at(index) # denna fungerar ej
	

func nearestPoint() -> Area2D:
	if yankPoints.size() <= 0:
		nearest = null
	
	for point : Area2D in yankPoints:
		if nearest == null:
			nearest = point
			continue
		
		if point.global_position.distance_to(player.global_position) < nearest.global_position.distance_to(player.global_position):
			nearest = point
	updateArrow()
	
	return nearest

func updateArrow() -> void:
	if nearest != null:
		yankArrow.points[0] = nearest.global_position - player.global_position
		yankArrow.points[1] = yankArrow.points[0] * 2

	elif nearest == null:
		yankArrow.points[1] = Vector2.ZERO
		yankArrow.points[2] = yankArrow.points[1]
		
		grapple_cursor.visible = false
