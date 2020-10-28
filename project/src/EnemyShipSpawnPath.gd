extends Path2D


export (PackedScene) var StandardEnemyEasy

var _current_max_enemies := 5
var _current_num_of_enemies := 0

func _ready():
	pass
	
func _process(delta):
	pass
	if _current_num_of_enemies < _current_max_enemies:
		var enemy = StandardEnemyEasy.instance()
		add_child(enemy)
		enemy.position = $SpawnLocation.position
		print("spawning enemy!")
		_current_num_of_enemies += 1
	


