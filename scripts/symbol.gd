extends Area2D

export var symbol: StreamTexture
export var number: int
export var pillar_path: NodePath
export var pillar_path_2: NodePath
var time: float
var particles = preload("res://scenes/CollectParticles.tscn")
var text = preload("res://scenes/CollectText.tscn")
onready var default_pos: Vector2 = position
onready var pillar = get_node(pillar_path)

func _physics_process(delta):
	time += delta
	position = default_pos + Vector2(0, sin(time * 2) * 2)

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		AudioManager.play("res://audio/sfx/collect.wav")

		var collect = particles.instance()
		collect.position = position
		collect.emitting = true
		get_parent().add_child(collect)

		var collect_text = text.instance()
		collect_text.position = position
		collect_text.symbol = symbol
		get_parent().add_child(collect_text)

		get_parent().get_parent().get_node("Runes/%s/Light" % number).visible = true

		if pillar_path_2:
			var pillar2 = get_node(pillar_path_2)
			$Tween2.interpolate_property(pillar2, "position", pillar2.position, pillar2.position - Vector2(0, 32), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
			$Tween2.start()

		$Tween.interpolate_property(pillar, "position", pillar.position, pillar.position - Vector2(0, 32), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
		$Tween.start()
		if number == 3:
			get_parent().get_parent().emit_signal("all")
		yield($Tween, "tween_all_completed")
		queue_free()
