extends KinematicBody2D

signal dead
const SPEED: float = 100.0
const JUMP_HEIGHT: float = 300.0
const GRAVITY: float = 20.0
var velocity: Vector2
var jumping: bool

func _ready():
	connect("dead", self, "_on_dead")

func _physics_process(_delta):
	var direction: float = Input.get_action_strength("right") - Input.get_action_strength("left")

	if is_on_floor() and jumping:
		jumping = false

	if !jumping:
		if abs(direction) > 0:
			$Sprite.animation = "walk"
		else:
			$Sprite.animation = "idle"

	$Sprite.flip_h = direction < 0

	if Input.is_action_just_pressed("jump"):
		jump()

	velocity.x = lerp(velocity.x, direction * SPEED, 0.4)
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)

func jump():
	if is_on_floor():
		velocity.y -= JUMP_HEIGHT
		$Sprite.animation = "jump"
		jumping = true

func _on_dead():
	pass # restart from the last checkpoint
