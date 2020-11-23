# Handles scrolling background, global values such as scoring, music,
# and end of level situations. Also handles launching asteroid hazards
# IGNORED WARNINGS:
# the connect() functions returned a value I could not access 
# nor do I need to use, even though the signal itself is still used
extends Node2D

const SPEED := 1

export (PackedScene) var _asteroid_one 
var _ships_destroyed := 0
var _scrolling_enabled := true
var _boss_fight_time := 0.0

onready var _HUD := $HUD
onready var _background := $ParallaxBackground/ParallaxLayer
onready var _menu_scene := load("res://src/Menu.tscn")
onready var _gameplay_scene = load("res://src/LevelOne/LevelOne.tscn")

func _ready():
	$AnimationPlayer.play("transition")
# warning-ignore:return_value_discarded
	$Player.connect("player_defeated",self,"_on_player_defeat")
# warning-ignore:return_value_discarded
	$Player.connect("cheats_enabled",self,"_activate_cheats")
# warning-ignore:return_value_discarded
	$ShipSpawns.connect("boss_released",self,"_boss_setup")
# warning-ignore:return_value_discarded
	$ShipSpawns.connect("ship_destroyed",self,"_add_score")
# warning-ignore:return_value_discarded
	$LevelOneBoss.connect("boss_defeated",self,"_on_level_complete")
	$Player.current_pos = $PlayerSpawn.position
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
	
	
func _process(delta):
	if !_scrolling_enabled:
		_boss_fight_time += delta
	if Input.is_action_pressed("pause_game"):
		_on_pause_pressed()
	if Input.is_action_pressed("return_to_menu"):
		$AnimationPlayer.play("backwards_transition")
		
		
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
	
	
func _boss_setup():
	_scrolling_enabled = false
	$HazardTimer.stop()
	$LevelOneBoss.set_process(true)
	$LevelOneBoss/HitBox.show()
	$LevelOneBoss/StandardAttackDelay.start()
	$LevelOneBoss/SpecialAttackDelay.start()
	
	
func _on_level_complete():
	remove_child($LevelOneBoss)
	$MusicLoop.stop()
	$LevelCompleteMenu/WinSound.play()
	$LevelCompleteMenu/CompletePanel.show()
	$Player.set_process(false)
	$LevelCompleteMenu/CompletePanel/RegularDestroyedLabel.text = "Total Ships Destroyed: " +str(_ships_destroyed)
	$LevelCompleteMenu/CompletePanel/PowerupsCollectLabel.text = "Powerups Collected: " + str($Player.powerups_collected)
	$LevelCompleteMenu/CompletePanel/BossTimeLabel.text = "Time to Defeat Boss: " + str(int(_boss_fight_time)) + " seconds"


func _activate_cheats():
	print("ending formations...")
	$ShipSpawns.formation_num = 9
	
	
func _on_hazard_timer_timeout():
	var _new_hazard = _asteroid_one.instance()
	add_child(_new_hazard)


func _on_ReturnMenuButton_pressed():
	get_tree().paused = false
	$PauseMenu/PausePanel.hide()
	$AnimationPlayer.play("backwards_transition")
