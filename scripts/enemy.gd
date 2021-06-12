extends KinematicBody2D

const CLOSE: float = 40.0
const FAR: float = 120.0
const SPEED: float = 150.0
var velocity: Vector2
var direction: Vector2
var attack = preload("res://scenes/Attack.tscn")
var RNG = RandomNumberGenerator.new()
onready var player = get_node("../Player")

func _ready():
	RNG.randomize()

func _physics_process(delta):
	var distance: float = position.distance_to(player.position)
	if distance <= CLOSE:
		direction = -position.direction_to(player.position)
	elif distance >= FAR:
		direction = position.direction_to(player.position)
	else:
		direction = Vector2()

	if $Animation.animation != "shoot":
		if direction.length() > 0:
			$Animation.animation = "move"
		else:
			$Animation.animation = "idle"

	if direction.x > 0:
		$Animation.flip_h = false
	elif direction.x < 0:
		$Animation.flip_h = true

	velocity = velocity.linear_interpolate(direction * SPEED, 0.02)
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI / 4, false)

func attack():
	$Animation.animation = "shoot"
	yield($Animation, "animation_finished")

	var attack_dir = position.direction_to(player.position).rotated(RNG.randf_range(-0.1, 0.1))

	var atk = attack.instance()
	atk.direction = attack_dir
	atk.position = position
	get_parent().add_child(atk)

	$Animation.animation = "idle"

func _on_Timer_timeout():
	attack()

func _on_Area_body_entered(body: Node2D):
	if body is TileMap:
		velocity.y -= 30
