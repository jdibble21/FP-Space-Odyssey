# Handles menu animation and loading the gameplay scenes on
# button press
extends CanvasLayer

onready var _gameplay_scene = load("res://src/LevelOne/LevelOne.tscn")

func _ready():
	$ShipSprite/ShipExhaust.play("active")
	$MenuMusic.play()


func _on_PlayButton_pressed():
	queue_free()
	get_tree().get_root().add_child(_gameplay_scene.instance())
