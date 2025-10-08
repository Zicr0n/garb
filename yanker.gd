extends CharacterBody2D

var nearestYank = null
@export var yankPower = 1000
@export var yankArrow : Line2D = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("grapple"):
		if nearestYank:
			yank()
			#statemachine.disabled = true
			return

@onready var statemachine: PlayerStateMachine = $Statemachine

func yank():
	var direction = (nearestYank.global_position - global_position).normalized()
	var force : Vector2 = direction * yankPower

	velocity = force

func _physics_process(delta: float) -> void:
	if is_on_floor():
		statemachine.disabled = false
	move_and_slide()
	updateYankArrow()

func _on_yank_detect_area_entered(area: Area2D) -> void:
	nearestYank = area


func _on_yank_detect_area_exited(_area: Area2D) -> void:
	nearestYank = null
	pass # Replace with function body.

func updateYankArrow():
	if nearestYank != null:
		yankArrow.points[1] = nearestYank.position - position
		yankArrow.points[2] = yankArrow.points[1] * 2
	elif nearestYank == null:
		yankArrow.points[1] = Vector2.ZERO
		yankArrow.points[2] = yankArrow.points[1]
