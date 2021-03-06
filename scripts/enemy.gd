extends KinematicBody2D

const CLOSE: float = 30.0
const FAR: float = 70.0
const SPEED: float = 150.0
var overlapping: Node2D
var velocity: Vector2
var direction: Vector2
var attack = preload("res://scenes/Attack.tscn")
var RNG = RandomNumberGenerator.new()
onready var scripted: bool = get_parent().name == "Forest"
onready var player = get_node("../Player")

func _ready():
	RNG.randomize()

func _physics_process(delta):
	var distance: float = position.distance_to(player.position)
	if !scripted:
		if distance <= CLOSE:
			direction = -position.direction_to(player.position)
		elif distance >= FAR:
			direction = position.direction_to(player.position)
		else:
			direction = Vector2()
	elif distance < 200.0:
		direction = Vector2.RIGHT / 1.5
	else:
		direction = position.direction_to(player.position)

	if $Animation.animation != "shoot":
		if direction.length() > 0:
			$Animation.animation = "move"
		else:
			$Animation.animation = "idle"

	if direction.x > 0:
		$Animation.flip_h = false
	elif direction.x < 0:
		$Animation.flip_h = true

	if overlapping:
		if $Bottom.overlaps_body(overlapping):
			velocity.y -= 3

	velocity = velocity.linear_interpolate(direction * SPEED, 0.02)
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI / 4, false)

func attack():
	AudioManager.play("res://audio/sfx/enemy_charge.wav")
	$Animation.animation = "shoot"
	yield($Animation, "animation_finished")

	var attack_dir = position.direction_to(player.position).rotated(RNG.randf_range(-0.1, 0.1))

	var atk = attack.instance()
	atk.direction = attack_dir
	atk.position = position
	get_parent().add_child(atk)

	AudioManager.play("res://audio/sfx/enemy_shoot.wav")

	$Animation.animation = "idle"

func _on_Timer_timeout():
	attack()

func _on_Area_body_entered(body: Node2D):
	if body is TileMap:
		overlapping = body

func _on_Area_body_exited(body: Node2D):
	if body is TileMap:
		overlapping = null

func _on_top_body_entered(body: Node2D):
	if body is TileMap:
		velocity.y += 50
