extends KinematicBody2D

signal dead
const SPEED: float = 100.0
const JUMP_HEIGHT: float = 300.0
const GRAVITY: float = 20.0
var velocity: Vector2
var jumping: bool
onready var checkpoint: Vector2 = position

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
		jumping = true

		$Sprite.animation = "jump"
		AudioManager.play("res://audio/sfx/jump.wav")

func _on_dead():
	AudioManager.play("res://audio/sfx/hit.wav")
	yield(Transitioner.transition_start(), "completed")
	position = checkpoint
	get_node("../Enemy").position = position + Vector2(30, 0)
	Transitioner.transition_end()
