extends Area2D

var particles = preload("res://scenes/CollectParticles.tscn")

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		var collect = particles.instance()
		collect.position = position
		collect.emitting = true
		get_parent().add_child(collect)
		queue_free()
