extends Node2D

const ROID = preload("res://scenes/roid.tscn")
const COOLDOWN_ROID_SPAWN = 5
var cooldown = 5
var count_spawn_roid = 1
var score = 0
var score_display = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_display = find_child('score')
	spawn_roids(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_display.set('text', score)
	cooldown -= delta
	if (cooldown < 0):
		cooldown = COOLDOWN_ROID_SPAWN
		spawn_roids(count_spawn_roid)
		count_spawn_roid += 1

func spawn_roids(amount: int) -> void:
	var roid
	for i in amount:
		roid = ROID.instantiate()
		roid.initialize()
		add_child(roid)
