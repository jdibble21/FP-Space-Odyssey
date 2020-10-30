extends Area2D

export (PackedScene) var StandardEnemyEasy


var _current_max_enemies := 5
var _current_num_of_enemies := 0
var _spawn_pos := Vector2()
onready var _center_pos = self.position + $CollisionShape2D.position
onready var _area_width = $CollisionShape2D.shape.extents.x
onready var _area_height = $CollisionShape2D.shape.extents.y

func _ready():
	print(_area_width)
	pass
	
func _process(delta):
	_spawn_pos.x = (randi() % int(_area_width)) - int(_area_width/2) + int(_center_pos.x)
	_spawn_pos.y = (randi() % int(_area_height)) - int(_area_height/2) + int(_center_pos.y)
	if _current_num_of_enemies < _current_max_enemies:
		var enemy = StandardEnemyEasy.instance()
		add_child(enemy)
		enemy.position = _spawn_pos
		print("spawning enemy!")
		_current_num_of_enemies += 1
