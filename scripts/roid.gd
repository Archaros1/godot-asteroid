extends RigidBody2D

const SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var vector = get_direction_from_rota(rotation_degrees - 90)
	position = Vector2(position.x + (vector.x * SPEED * delta), position.y + (vector.y * SPEED * delta))


func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(deg_to_rad(angle)), 'y': sin(deg_to_rad(angle))}
