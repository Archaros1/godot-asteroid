extends Area2D

const SPEED_MIN = 3
const SPEED_MAX = 20
const FAST_SPEED_MIN = 100
const FAST_SPEED_MAX = 150
const SPAWN_COORD_X_LIMIT = 288
const SPAWN_COORD_Y_LIMIT = 162
var speed = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = randi_range(1, 8)
	scale = Vector2(size, size)
	speed = randi_range(FAST_SPEED_MIN, FAST_SPEED_MAX)
	# 5/6 chance to be slow
	if randi_range(0, 5):
		speed = randi_range(SPEED_MIN, SPEED_MAX)
	var wall = randi_range(1, 4) # 1: up, 2: down, 3: left, 4: right
	match wall:
		1: #up
			position = Vector2(
				randf_range(-1 * SPAWN_COORD_X_LIMIT, SPAWN_COORD_X_LIMIT),
				-1 * SPAWN_COORD_Y_LIMIT
			)
			rotation_degrees = randf_range(135, 225)
		2: #down
			position = Vector2(
				randf_range(-1 * SPAWN_COORD_X_LIMIT, SPAWN_COORD_X_LIMIT),
				SPAWN_COORD_Y_LIMIT
			)
			rotation_degrees = randf_range(-45, 45)
		3: #left
			position = Vector2(
				-1 * SPAWN_COORD_X_LIMIT,
				randf_range(-1 * SPAWN_COORD_Y_LIMIT, SPAWN_COORD_Y_LIMIT)
			)
			rotation_degrees = randf_range(45, 135)
		4: #right
			position = Vector2(
				SPAWN_COORD_X_LIMIT,
				randf_range(-1 * SPAWN_COORD_Y_LIMIT, SPAWN_COORD_Y_LIMIT),
			)
			rotation_degrees = randf_range(225, 270)
	

func _physics_process(delta: float) -> void:
	var vector = get_direction_from_rota(rotation_degrees - 90)
	position = Vector2(position.x + (vector.x * speed * delta), position.y + (vector.y * speed * delta))


func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(deg_to_rad(angle)), 'y': sin(deg_to_rad(angle))}
