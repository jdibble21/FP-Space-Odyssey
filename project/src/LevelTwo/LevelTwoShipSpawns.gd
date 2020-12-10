# Handles spawning of Level one ships via separate formations randomly 
# selected each spawn wave, handled by a timer timeout() function
extends Node

signal boss_released
signal ship_destroyed

const MAX_FORMATIONS := 8

export (PackedScene) var _boss
export (PackedScene) var _basic_ship
export (PackedScene) var _advanced_ship

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


func _on_FormationSpawnTimer_timeout():
	
