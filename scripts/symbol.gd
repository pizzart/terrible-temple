extends Area2D

export var symbol: StreamTexture
export var number: int
var time: float
var particles = preload("res://scenes/CollectParticles.tscn")
var text = preload("res://scenes/CollectText.tscn")
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

		var collect_text = text.instance()
		collect_text.position = position
		collect_text.symbol = symbol
		get_parent().add_child(collect_text)

		queue_free()
