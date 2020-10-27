extends Node2D

const SPEED := 4

onready var _background := $ParallaxBackground/ParallaxLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if _background.position.y >= 800:
		_background.motion_offset.y = 0
	_background.motion_offset.y += SPEED
		
