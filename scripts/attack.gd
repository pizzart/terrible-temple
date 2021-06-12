extends Area2D

var direction: Vector2

func _physics_process(delta):
	position += direction * delta * 200

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		body.emit_signal("dead")
	elif body is TileMap:
		# play an explosion animaiton or smth
		queue_free()

func _on_timeout():
	queue_free()
