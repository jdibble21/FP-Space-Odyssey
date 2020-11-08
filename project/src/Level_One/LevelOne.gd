# Handles scrolling background, global values such as scoring, music,
# and end of level situations. Also handles launching asteroid hazards
extends Node2D

const SPEED := 2

export (PackedScene) var _asteroid_one 

onready var _HUD_time := $HUD
onready var _background := $ParallaxBackground/ParallaxLayer

func _ready():
	$Player.connect("player_defeated",self,"_on_player_defeat")
	$Player.current_pos = $PlayerSpawn.position
	$MusicLoop.play()


func _process(_delta):
	if _background.position.y >= 800:
		_background.motion_offset.y = 0
	_background.motion_offset.y += SPEED
	if _HUD_time.rounded_time >= 25:
		$HUD/GameOverLabel.show()
		$MusicLoop.stop()
		get_tree().paused = true
		
		
func _on_player_defeat():
	$MusicLoop.stop()
	$HUD/DefeatLabel.show()
	set_process(false)
	$Player.queue_free()
	
	
func _on_hazard_timer_timeout():
	# Refactor to randomly add different types later
	var _new_hazard = _asteroid_one.instance()
	add_child(_new_hazard)
