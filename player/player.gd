extends CharacterBody2D

var nearestGrapplePoint : Area2D = null
var is_grappling = false
var grap_dist = 100

#var grap_length = 100.0
var stiffness = 100.0
var dampening = 20.0

var grap_length = 100

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("grapple"):
		if nearestGrapplePoint:
			is_grappling = true
			statemachine.disabled = true
			grap_length = global_position.distance_to(nearestGrapplePoint.global_position)
			return
	
	if event.is_action_released("grapple"):
		if is_grappling:
			is_grappling = false
			statemachine.disabled = false
			return

@onready var statemachine: PlayerStateMachine = $Statemachine

func grapple(delta):
	if nearestGrapplePoint == null:
		statemachine.disabled = false
		return
	
	var direction = (nearestGrapplePoint.global_position - global_position).normalized()
	var distance = global_position.distance_to(nearestGrapplePoint.global_position)
	
	# grap length is the resting length of the "spring", whereas distance is the stretched one (current one)
	var stretch = distance - grap_length 
	
	var force = Vector2.ZERO
	
	if stretch > 0:
		var spring_force_strength = stiffness * stretch
		var spring_force_vector = direction * spring_force_strength
		
		# complex shit i dont understand it but it should work according to the internet <3
		var vel_dot = velocity.dot(direction) # velocity along rope axis
		var damping = -dampening * vel_dot * direction # Resisting the back and forth swing ????
		
		force = spring_force_vector + damping
	
	velocity += force * delta

func _physics_process(delta: float) -> void:
	if is_grappling:
		grapple(delta)
		#move_and_slide()

func _on_grapple_detect_area_entered(area: Area2D) -> void:
	""" Grapple point detected
	 also dont just overwrite the current area, because obviously only the first one should be used.
	 so change this in the future when everything else is working
	 please
	 - me
	"""
	nearestGrapplePoint = area
	print("Grapple point detected")


func _on_grapple_detect_area_exited(_area: Area2D) -> void:
	print("Grapple point exited")
	nearestGrapplePoint = null
	"""
	Same shit here, dont just nullify, check if there are others that can be used, which 
	obviously means that this should be a fucking array dang ill fix it later
	-me
	"""
	pass # Replace with function body.
