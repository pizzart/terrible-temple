extends Control

func _ready():
	$Main/Buttons/Start.grab_focus()

func _on_start():
	visible = false
	$Main/Buttons/Start.disabled = true
	$Main/Buttons/Quit.disabled = true

	yield(Transitioner.transition_start(), "completed")

	Cutscene.current = 1
	Cutscene.get_node("Video").visible = true
	Cutscene.get_node("Video").play()
	Transitioner.transition_end()
	yield(Cutscene.get_node("Video"), "finished")

	yield(Transitioner.transition_start(), "completed")
	Cutscene.get_node("Video").visible = false
	get_tree().change_scene("res://scenes/Forest.tscn")

func _on_start_focused():
	# play a sound
	$Main/Buttons/Start.text = "> Start Game"
	$Main/Buttons/Quit.text = "  Quit"

func _on_quit():
	yield(Transitioner.transition_start(), "completed")
	get_tree().quit()

func _on_quit_focused():
	# play a sound
	$Main/Buttons/Start.text = "  Start Game"
	$Main/Buttons/Quit.text = "> Quit"
