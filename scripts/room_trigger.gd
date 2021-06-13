extends Area2D

export var pillar_path: NodePath
var player: Node2D
onready var pillar = get_node(pillar_path)

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		player = body

	if body.is_in_group("Enemy"):
		if player:
			AudioManager.play("res://audio/sfx/pillar_close.wav")
			player.checkpoint = position
			$Tween.interpolate_property(pillar, "position", pillar.position, pillar.position + Vector2(0, 32), 0.5, Tween.TRANS_SINE, Tween.EASE_IN)
			$Tween.start()
			yield($Tween, "tween_all_completed")
			queue_free()
