extends CanvasLayer


var _time := 0.0 
var rounded_time := int(_time)

onready var _time_label := $TimeLabel
onready var _gameover_label := $GameOverLabel
onready var _defeat_label := $DefeatLabel

func _ready():
	_gameover_label.hide()
	_defeat_label.hide()

func _process(delta):
	_time += delta
	rounded_time = int(_time)
	_time_label.text = "TIME: " + str(rounded_time) 
