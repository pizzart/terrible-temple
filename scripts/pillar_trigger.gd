extends Area2D

export var pillar_path: NodePath
var player_entered: bool
onready var pillar = get_node(pillar_path)

func _ready():
	$Tween.interpolate_property(pillar, "position", pillar.position, pillar.position + Vector2(0, 32), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		player_entered = true

	if body.is_in_group("Enemy"):
		if player_entered:
			$Tween.start()
			yield($Tween, "tween_all_completed")
			queue_free()
