extends Node2D

onready var player = get_node("Player")
onready var enemy = get_node("Enemy")

func _draw():
	draw_line(player.position, enemy.position, Color.hotpink, 1.0)

func _process(delta):
	update()
