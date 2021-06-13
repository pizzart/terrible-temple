extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		yield(Transitioner.transition_start(), "completed")
		Cutscene.current = 2
		Cutscene.get_node("Video").stream = preload("res://graphics/cutscene2.ogv")
		Cutscene.get_node("Video").play()
		Cutscene.get_node("Video").visible = true
		Transitioner.transition_end()
		get_parent().get_parent().queue_free()
