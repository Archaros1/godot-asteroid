extends Node2D

const ROID = preload("res://scenes/roid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_roids(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_roids(amount: int) -> void:
	for i in amount:
		add_child(ROID.instantiate())
