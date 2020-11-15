extends Node

signal boss_released

const MAX_FORMATIONS := 8

export (PackedScene) var _boss
export (PackedScene) var _basic_ship
export (PackedScene) var _advanced_ship

var _basic_formation_one := {
	"pos1":[50,-153],
	"pos2":[99,-110],
	"pos3":[149,-79]
} 
var _basic_formation_two := {
	"pos1":[652,-167],
	"pos2":[588,-109],
	"pos3":[535,-60]
}
var _basic_formation_three := {
	"pos1":[354,-73],
	"pos2":[332,-136],
	"pos3":[402,-136]
}
var _advanced_formation_one := {
	"pos1":[219,-28],
	"pos2":[496,-28],
	"pos3":[354,-73]
}
var formation_num := 0

func _ready():
	randomize()
	var _formation_one_initial := randi()%3+1
	var _formation_two_initial := randi()%3+1
	# Ensure formations are different
	while _formation_two_initial == _formation_one_initial:
		_formation_two_initial = randi()%3+1
	if _formation_one_initial == 1 or _formation_two_initial == 1:
		_spawn_basic_ship_formation(_basic_formation_one)
	if _formation_one_initial == 2 or _formation_two_initial == 2:
		_spawn_basic_ship_formation(_basic_formation_two)
	if _formation_one_initial == 3 or _formation_two_initial == 3:
		_spawn_basic_ship_formation(_basic_formation_three)
	
	
func _get_formation(num):
	if num == 1:
		return _basic_formation_one
	if num == 2:
		return _basic_formation_two
	if num == 3:
		return _basic_formation_three


func _on_FormationSpawnTimer_timeout():
	print("formation num: " + str(formation_num))
	formation_num += 1
	if formation_num == 7:
		$FormationSpawnTimer.wait_time = 2.5
	# Every timer timeout, a random formation is selected and spawned
	var _new_formation_num := randi()%3+1
	_spawn_basic_ship_formation(_get_formation(_new_formation_num))
	if formation_num >= 7:
		_spawn_advanced_ship_formation()
	if formation_num >= MAX_FORMATIONS:
		remove_child($FormationSpawnTimer)
		_spawn_levelone_boss()
		return
	
	
func _spawn_basic_ship_formation(formation):
	var _ship_one = _basic_ship.instance()
	var _ship_two = _basic_ship.instance()
	var _ship_three = _basic_ship.instance()
	add_child(_ship_one)
	add_child(_ship_two)
	add_child(_ship_three)
	_ship_one.position = Vector2(formation["pos1"][0],formation["pos1"][1])
	_ship_two.position = Vector2(formation["pos2"][0],formation["pos2"][1])
	_ship_three.position = Vector2(formation["pos3"][0],formation["pos3"][1])
	
	
func _spawn_advanced_ship_formation():
	var formation = _advanced_formation_one
	var _ship_one = _advanced_ship.instance()
	var _ship_two = _advanced_ship.instance()
	var _ship_three = _advanced_ship.instance()
	add_child(_ship_one)
	add_child(_ship_two)
	add_child(_ship_three)
	_ship_one.position = Vector2(formation["pos1"][0],formation["pos1"][1])
	_ship_two.position = Vector2(formation["pos2"][0],formation["pos2"][1])
	_ship_three.position = Vector2(formation["pos3"][0],formation["pos3"][1])
	
	
func _spawn_levelone_boss():
	emit_signal("boss_released")
	
