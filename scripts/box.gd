extends KinematicBody2D

var chained: bool = true
var velocity: Vector2

func _physics_process(delta):
	if !chained:
		velocity.y += 10
		velocity = move_and_slide(velocity)
