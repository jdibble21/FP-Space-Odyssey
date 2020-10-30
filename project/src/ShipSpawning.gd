# Handles spawning enemy ships (only standardenemies) 
extends Area2D

export (PackedScene) var StandardEnemyEasy

var _current_max_enemies := 5
var _current_num_of_enemies := 0
var _spawn_pos := Vector2()
onready var _center_pos = self.position + $CollisionShape2D.position
onready var _area_width = $CollisionShape2D.shape.extents.x * 2
onready var _area_height = $CollisionShape2D.shape.extents.y

func _ready():
	randomize()
	
	
func _process(delta):
	_spawn_pos.x = randi()%int(_area_width)+1
	_spawn_pos.y = randi()%int(_area_height)+1
	if _current_num_of_enemies < _current_max_enemies:
		var enemy = StandardEnemyEasy.instance()
		add_child(enemy)
		enemy.position = _spawn_pos
		print("spawning enemy!")
		_current_num_of_enemies += 1
