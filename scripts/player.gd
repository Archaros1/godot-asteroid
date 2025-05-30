extends CharacterBody2D

const SPEED = 150.0
const DECELERATION = 5
const BULLET = preload("res://scenes/bullet.tscn")
const SHOOT_COOLDOWN_TIME = 0.8
var shoot_cooldown = 0
@onready var game: Node2D = $".."

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		rotate(deg_to_rad(-80 * delta))
	if Input.is_action_pressed("ui_right"):
		rotate(deg_to_rad(80 * delta))
	if Input.is_action_pressed("ui_up"):
		# Once we start moving.
		var vector = get_direction_from_rota(rotation_degrees - 90)
		velocity.x = vector.x * SPEED
		velocity.y = vector.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
	
	if shoot_cooldown > 0:
		shoot_cooldown -= delta
	
	if Input.is_action_pressed("ui_accept") && shoot_cooldown <= 0:
		shoot_cooldown = SHOOT_COOLDOWN_TIME
		game.add_child(BULLET.instantiate())
	
	move_and_slide()

func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(deg_to_rad(angle)), 'y': sin(deg_to_rad(angle))}
