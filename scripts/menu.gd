extends Control

func _ready():
	$Main/Buttons/Start.grab_focus()

func _on_start():
	yield(Transitioner.transition_start(), "completed")
	get_tree().change_scene("res://scenes/Forest.tscn")
	Transitioner.transition_end()

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
