extends Area2D

const SPEED_MIN = 3
const SPEED_MAX = 10
const FAST_SPEED_MIN = 20
const FAST_SPEED_MAX = 30
const SPAWN_COORD_X_LIMIT = 288
const SPAWN_COORD_Y_LIMIT = 162
var speed = null
const ROID = preload("res://scenes/roid.tscn")
@onready var game: Node2D = $".."
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = randi_range(FAST_SPEED_MIN, FAST_SPEED_MAX)

func initialize() -> void:
	var size = randi_range(1, 4) * 2
	scale = Vector2(size, size)
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
		2: #down
			position = Vector2(
				randf_range(-1 * SPAWN_COORD_X_LIMIT, SPAWN_COORD_X_LIMIT),
				SPAWN_COORD_Y_LIMIT
			)
		3: #left
			position = Vector2(
				-1 * SPAWN_COORD_X_LIMIT,
				randf_range(-1 * SPAWN_COORD_Y_LIMIT, SPAWN_COORD_Y_LIMIT)
			)
		4: #right
			position = Vector2(
				SPAWN_COORD_X_LIMIT,
				randf_range(-1 * SPAWN_COORD_Y_LIMIT, SPAWN_COORD_Y_LIMIT),
			)
	look_at(Vector2(0, 0))
	rotation_degrees += 90
	rotation_degrees = randf_range(rotation_degrees - 20, rotation_degrees + 20)

func _physics_process(delta: float) -> void:
	var vector = get_direction_from_rota(rotation_degrees - 90)
	position = Vector2(position.x + (vector.x * speed * delta), position.y + (vector.y * speed * delta))

func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(deg_to_rad(angle)), 'y': sin(deg_to_rad(angle))}

func _on_area_entered(area: Area2D) -> void:
	$CPUParticles2D.emitting = true
	timer.start()
	spawn_roid_children()
	area.queue_free()
	game.score += 1
	$Sprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", true)

func spawn_roid_children() -> void:
	if (scale.x >= 2):
		var roid_child_1 = ROID.instantiate()
		var roid_child_2 = ROID.instantiate()
		var scaler_coeff_x = randi_range(0, 1) * 2
		var scaler_coeff_y = randi_range(0, 1) * 2
		roid_child_1.scale.x = (scale.x / 2) - scaler_coeff_x
		roid_child_1.scale.y = (scale.y / 2) - scaler_coeff_x
		roid_child_2.scale.x = (scale.x / 2) - scaler_coeff_y
		roid_child_2.scale.y = (scale.y / 2) - scaler_coeff_y
		roid_child_1.position = position
		roid_child_2.position = position
		roid_child_1.rotation = rotation
		roid_child_2.rotation = rotation
		
		roid_child_1.rotation_degrees += 45 + randi_range(-30, 30)
		roid_child_2.rotation_degrees -= 45 + randi_range(-30, 30)
		
		game.add_child(roid_child_1)
		game.add_child(roid_child_2)

func _on_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
