# Handles scrolling background, global values such as scoring, music,
# and end of level situations
extends Node2D

const SPEED := 4

onready var _background := $ParallaxBackground/ParallaxLayer

func _ready():
	randomize()
	pass # Replace with function body.


func _process(delta):
	if _background.position.y >= 800:
		_background.motion_offset.y = 0
	_background.motion_offset.y += SPEED
		
