extends Area2D

var direction: Vector2
var explosion_p = preload("res://scenes/ExplosionParticles.tscn")

func _physics_process(delta):
	position += direction * delta * 200

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		body.emit_signal("dead")
		queue_free()
	elif !body.is_in_group("Enemy"):
		AudioManager.play("res://audio/sfx/attack_explosion.wav")

		var particles = explosion_p.instance()
		particles.position = position
		particles.emitting = true
		get_parent().add_child(particles)

		queue_free()

func _on_area_entered(area: Area2D):
	if area.is_in_group("Chain"):
		AudioManager.play("res://audio/sfx/attack_explosion.wav")

		var particles = explosion_p.instance()
		particles.position = position
		particles.emitting = true
		get_parent().add_child(particles)

		area.get_node("../Box").chained = false
		area.queue_free()

		queue_free()

func _on_timeout():
	queue_free()
