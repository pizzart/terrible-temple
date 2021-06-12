extends Area2D

var direction: Vector2

func _physics_process(delta):
	position += direction * delta * 200

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		body.emit_signal("dead")
	elif !body.is_in_group("Enemy"):
		# play an explosion animaiton or smth
		queue_free()

func _on_area_entered(area: Area2D):
	if area.is_in_group("Chain"):
		area.get_node("../Box").chained = false
		area.queue_free()
		queue_free()

func _on_timeout():
	queue_free()
