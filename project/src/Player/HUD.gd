# Handles hiding some HUD elements, and keeping an upticking
# timer for game time
extends CanvasLayer

var _time := 0.0 
var rounded_time := int(_time)

onready var _time_label := $TimeLabel
onready var _gameover_label := $GameOverLabel
onready var _defeat_label := $DefeatLabel
onready var _finalscore_label := $FinalScoreLabel
onready var _lives_label := $LivesLabel

func _ready():
	_gameover_label.hide()
	_defeat_label.hide()
	_finalscore_label.hide()
	_lives_label.text = "EXTRA LIVES: 1"
	
	
func _process(delta):
	_time += delta
	rounded_time = int(_time) 
