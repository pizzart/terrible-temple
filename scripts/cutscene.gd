extends CanvasLayer

var current: int = 0

func _on_Video_finished():
	if current == 2:
		yield(Transitioner.transition_start(), "completed")
		$Video.visible = false
		get_tree().change_scene("res://scenes/Temple.tscn")
		Transitioner.transition_end()
