# Handles scrolling background, global values such as scoring, music,
# and end of level situations. Also handles launching asteroid hazards
extends Node2D

const SPEED := 2

export (PackedScene) var _asteroid_hazard
var _ships_destroyed := 0
var _scrolling_enabled := true
var _boss_fight_time := 0.0

onready var _HUD := $HUD
onready var _background := $ParallaxBackground/ParallaxLayer
onready var _menu_scene := load("res://src/Menu.tscn")
onready var _gameplay_scene = load("res://src/LevelTwo/LevelTwo.tscn")

func _ready():
	randomize()
# warning-ignore:return_value_discarded
	$Player.connect("player_defeated",self,"_on_player_defeat")
# warning-ignore:return_value_discarded
	$Player.current_pos = $PlayerSpawn.position
	$ShipSpawns.connect("ship_destroyed",self,"_add_score")
	$PauseMenu/PausePanel.hide()
	$MusicLoop.play()

func _physics_process(_delta):
	if _scrolling_enabled:
		if _background.position.y >= 815:
			_background.motion_offset.y = 0
		_background.motion_offset.y += SPEED
	$HUD/TimeLabel.text = "TIME: " + str(_HUD.rounded_time)
	$HUD/ScoreLabel.text = "SHIPS DESTROYED: " + str(_ships_destroyed)
	$HUD/LivesLabel.text = "EXTRA LIVES: " + str($Player.player_lives)
	
func _process(_delta):
	if Input.is_action_pressed("pause_game"):
		_on_pause_pressed()
	if Input.is_action_pressed("return_to_menu"):
		queue_free()
		get_tree().get_root().add_child(_menu_scene.instance())
		
		
func _on_player_defeat():
	set_physics_process(false)
	$HazardTimer.stop()
	$HUD.set_process(false)
	$MusicLoop.stop()
	$HUD/DefeatLabel.show()
	$Player.queue_free()
	
	
func _on_pause_pressed():
	get_tree().paused = true
	$PauseMenu/PausePanel.show()
	
	
func _add_score():
	_ships_destroyed += 1
	
	
func _on_hazard_timer_timeout():
	var _new_hazard = _asteroid_hazard.instance()
	add_child(_new_hazard)

