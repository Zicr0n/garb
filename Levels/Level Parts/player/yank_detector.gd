extends Area2D
class_name YankDetector

@export var player : Player = null
@export var yankArrow : Line2D = null
@export var grapple_cursor : Sprite2D = null
@onready var obstruction_ray: RayCast2D = $RayCast2D

var yankPoints : Array[YankPoint]
var nearest : YankPoint = null

func _physics_process(delta: float) -> void:
	update_ray(nearest)
	nearestPoint()
	updateArrow()
	
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

# helt outrageous hur du hade implementerat det här, poopgoon. jag var tvungen att ändra det min själ kunde inte hålla sig
# - zicron
func get_nearest_point() -> YankPoint:
	if obstruction_ray.is_colliding():
		return null
	return nearest

func update_ray(yankPoint : YankPoint):
	if yankPoint == null:
		obstruction_ray.target_position = Vector2.ZERO
		return
	
	var target_pos_local = yankPoint.global_position - global_position
	obstruction_ray.target_position = target_pos_local

func nearestPoint() -> void:
	if yankPoints.size() <= 0:
		nearest = null
		return
	
	for point : Area2D in yankPoints:
		if nearest == null:
			nearest = point
			continue
		
		if point.global_position.distance_to(player.global_position) < nearest.global_position.distance_to(player.global_position):
			nearest = point
	

func updateArrow() -> void:
	if nearest != null:
		yankArrow.visible = true
		yankArrow.points[0] = nearest.global_position - player.global_position
		yankArrow.points[1] = yankArrow.points[0] * 2

	elif nearest == null:
		yankArrow.points[1] = Vector2.ZERO
		yankArrow.points[2] = yankArrow.points[1]
		
		yankArrow.visible = false
		
		grapple_cursor.visible = false
