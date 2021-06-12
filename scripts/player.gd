extends KinematicBody2D

signal dead
const SPEED: float = 100.0
const JUMP_HEIGHT: float = 250.0
const GRAVITY: float = 20.0
var velocity: Vector2

func _ready():
	connect("dead", self, "_on_dead")

func _physics_process(_delta):
	var direction: float = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = lerp(velocity.x, direction * SPEED, 0.4)
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)

func jump():
	if is_on_floor():
		velocity.y -= JUMP_HEIGHT

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		jump()

func _on_dead():
	pass # restart from the last checkpoint
