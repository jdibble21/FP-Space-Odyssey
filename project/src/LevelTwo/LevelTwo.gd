extends Node2D


const SPEED := 2

export (PackedScene) var _asteroid_one 
var _ships_destroyed := 0

onready var _HUD := $HUD
onready var _background := $ParallaxBackground/ParallaxLayer
onready var _menu_scene := load("res://src/Menu.tscn")
onready var _gameplay_scene = load("res://src/LevelOne/LevelOne.tscn")

func _ready():
# warning-ignore:return_value_discarded
	$Player.connect("player_defeated",self,"_on_player_defeat")
# warning-ignore:return_value_discarded
	$Player.connect("enemy_destroyed",self,"_add_score")
	$Player.current_pos = $PlayerSpawn.position
	$PauseMenu/PausePanel.hide()
	$MusicLoop.play()

func _physics_process(_delta):
	if _background.position.y >= 800:
		_background.motion_offset.y = 0
	_background.motion_offset.y += SPEED
	$HUD/TimeLabel.text = "TIME: " + str(_HUD.rounded_time)
	$HUD/ScoreLabel.text = "SHIPS DESTROYED: " + str(_ships_destroyed)
	
	
