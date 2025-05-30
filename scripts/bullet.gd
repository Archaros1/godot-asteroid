extends Area2D

const SPEED = 200
@onready var player: Node2D = $'../player'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player.position
	rotation = player.rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var vector = get_direction_from_rota(rotation_degrees - 90)
	
	position = Vector2(position.x + (vector.x * SPEED * delta), position.y + (vector.y * SPEED * delta))


func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(deg_to_rad(angle)), 'y': sin(deg_to_rad(angle))}
