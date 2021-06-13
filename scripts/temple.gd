extends Node2D

signal all
onready var player = get_node("Player")
onready var enemy = get_node("Enemy")

func _ready():
	connect("all", self, "_on_all")

func _draw():
	draw_line(player.position, enemy.position, Color.hotpink, 1.5)

func _process(delta):
	update()

func _on_all():
	$Platform.position.y -= 24
