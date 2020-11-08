# Handles scrolling background, global values such as scoring, music,
# and end of level situations. Also handles launching asteroid hazards
extends Node2D

const SPEED := 2

export (PackedScene) var _asteroid_one 
var _ships_destroyed := 0

onready var _HUD := $HUD
onready var _background := $ParallaxBackground/ParallaxLayer

func _ready():
# warning-ignore:return_value_discarded
	$Player.connect("player_defeated",self,"_on_player_defeat")
# warning-ignore:return_value_discarded
	$Player.connect("enemy_destroyed",self,"_add_score")
	$Player.current_pos = $PlayerSpawn.position
	$PauseMenu/PausePanel.hide()
	$MusicLoop.play()


func _process(_delta):
	if Input.is_action_pressed("pause_game"):
		_on_pause_pressed()
	if _background.position.y >= 800:
		_background.motion_offset.y = 0
	_background.motion_offset.y += SPEED
	# Update HUD values
	$HUD/TimeLabel.text = "TIME: " + str(_HUD.rounded_time)
	$HUD/ScoreLabel.text = "SHIPS DESTROYED: " + str(_ships_destroyed)
	if _HUD.rounded_time >= 25:
		$HUD/GameOverLabel.show()
		$MusicLoop.stop()
		get_tree().paused = true
		
		
func _on_player_defeat():
	$HUD.set_process(false)
	$MusicLoop.stop()
	$HUD/DefeatLabel.show()
	set_process(false)
	$Player.queue_free()
	
	
func _on_pause_pressed():
	get_tree().paused = true
	$PauseMenu/PausePanel.show()
	
	
func _add_score():
	_ships_destroyed += 1
	
	
func _on_hazard_timer_timeout():
	# Refactor to randomly add different types later
	var _new_hazard = _asteroid_one.instance()
	add_child(_new_hazard)
