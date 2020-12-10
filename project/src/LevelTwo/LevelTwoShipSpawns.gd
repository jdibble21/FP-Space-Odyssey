# Handles spawning of Level one ships via separate formations randomly 
# selected each spawn wave, handled by a timer timeout() function
extends Node

signal boss_released
signal ship_destroyed

const MAX_FORMATIONS := 9

export (PackedScene) var _boss
export (PackedScene) var _basic_ship
export (PackedScene) var _speed_ship
export (PackedScene) var _advanced_ship
export (PackedScene) var _homing_ship

var _speed_formation := {
	"pos1":[502,-70],
	"pos2":[207,-70],
} 
var _basic_formation_one := {
	"pos1":[78,-41],
	"pos2":[134,-41],
	"pos3":[181,-41]
} 
var _basic_formation_two := {
	"pos1":[50,-153],
	"pos2":[99,-110],
	"pos3":[149,-79]
} 
var _basic_special_formation_one := {
	
}

var _basic_special_formation_two := {
	
}

var _basic_special_formation_three := {
	
}

var formation_num := 0


func _on_FormationSpawnTimer_timeout():
	if formation_num < 3:
		_spawn_basic_ship_formation()
	if formation_num >= 3 and formation_num < 6:
		_spawn_special_ship_formation()
	formation_num += 1
	
	
func _spawn_basic_ship_formation():
	var formation = _get_basic_formation(randi()%2+1)
	for i in range(0,3):
		_spawn_ship(formation,i+1,_basic_ship)
		
func _spawn_special_ship_formation():
	pass
	
	
func _spawn_speed_ship_formation():
	for i in range(0,2):
		print("spawning ship into formation! num:"+str(i+1))
		_spawn_ship(_speed_formation,i+1,_speed_ship)
	
	
func _spawn_ship(formation_pos,set_num,ship_type):
	var root_attach = get_tree().get_root().get_node(owner.name)
	var _new_ship = ship_type.instance()
	root_attach.call_deferred("add_child",_new_ship)
	_new_ship.connect("destroyed",self,"_on_ship_destroyed")
	_new_ship.position = Vector2(formation_pos["pos"+str(set_num)][0],formation_pos["pos"+str(set_num)][1])

func _get_basic_formation(num):
	if num == 1:
		return _basic_formation_one
	if num == 2:
		return _basic_formation_two


func _on_SpeedShipSpawnTimer_timeout():
	_spawn_speed_ship_formation()
