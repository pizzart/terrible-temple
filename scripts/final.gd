extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Transitioner.transition_start()
		Transitioner.get_node("Thx").visible = true
