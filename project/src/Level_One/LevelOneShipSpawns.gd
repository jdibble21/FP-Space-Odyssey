extends Node


export (PackedScene) var _basic_ship

const NUM_OF_FORMATIONS := 2

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
var _num_of_formations_allowed := 2


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

