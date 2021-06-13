extends StaticBody2D

var moving: bool

func _physics_process(delta):
	if moving:
		position.y -= 9

func _on_body_entered(body):
	if body.is_in_group("Player"):
		moving = true
