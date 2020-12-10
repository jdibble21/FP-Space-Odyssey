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
export (PackedScene) var _special_basic_ship

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
	"pos1":[78,-29],
	"pos2":[114,-29],
	"pos3":[150,-29],
	"pos4":[186,-29]
}
var _basic_special_formation_two := {
	"pos1":[315,-25],
	"pos2":[378,-25],
	"pos3":[315,-88],
	"pos4":[378,-88]
}
var _basic_special_formation_three := {
	"pos1":[529,-37],
	"pos2":[570,-37],
	"pos3":[611,-37],
	"pos4":[570,-78]
}
var _advanced_formation_one := {
	"pos1":[219,-28],
	"pos2":[496,-28],
	"pos3":[354,-73]
}

var formation_num := 0


func _on_FormationSpawnTimer_timeout():
	if formation_num < 3:
		_spawn_basic_ship_formation()
	if formation_num >= 3 and formation_num < 7:
		_spawn_special_ship_formation()
	if formation_num >=7 and formation_num < 9:
		_spawn_special_ship_formation()
		_spawn_advanced_ship_formation()
	formation_num += 1
	
	
func _spawn_basic_ship_formation():
	var formation = _get_basic_formation(randi()%2+1)
	for i in range(0,3):
		_spawn_ship(formation,i+1,_basic_ship)
		
		
func _spawn_special_ship_formation():
	var formation = _get_special_formation(randi()%3+1)
	for i in range(0,4):
		_spawn_ship(formation,i+1,_special_basic_ship)
	
	
func _spawn_advanced_ship_formation():
	for i in range(0,3):
		_spawn_ship(_advanced_formation_one,i+1,_advanced_ship)
	
	
func _spawn_speed_ship_formation():
	for i in range(0,2):
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
func _get_special_formation(num):
	if num == 1:
		return _basic_special_formation_one
	if num == 2:
		return _basic_special_formation_two
	if num == 3:
		return _basic_special_formation_three
		
		
func _on_SpeedShipSpawnTimer_timeout():
	_spawn_speed_ship_formation()
	
func _on_ship_destroyed():
	emit_signal("ship_destroyed")
