extends Area2D

export var shape: RectangleShape2D

func _ready():
	$CollisionShape2D.shape = shape

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		body.emit_signal("dead")
