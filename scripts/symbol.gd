extends Area2D

var time: float
var particles = preload("res://scenes/CollectParticles.tscn")
onready var default_pos: Vector2 = position

func _physics_process(delta):
	time += delta
	position = default_pos + Vector2(0, sin(time * 2) * 2)

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		var collect = particles.instance()
		collect.position = position
		collect.emitting = true
		get_parent().add_child(collect)
		queue_free()
