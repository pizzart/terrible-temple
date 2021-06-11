extends KinematicBody2D

const SPEED: float = 200.0
const JUMP_HEIGHT: float = 400.0
const GRAVITY: float = 20.0
var velocity: Vector2

func _physics_process(_delta):
	var direction: float = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction * SPEED
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)

func jump():
	if is_on_floor():
		velocity.y -= JUMP_HEIGHT

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		jump()
