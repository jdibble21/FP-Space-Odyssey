extends CanvasLayer

onready var _gameplay_scene = load("res://src/Level_One/LevelOne.tscn")

func _ready():
	$ShipSprite/ShipExhaust.play("active")
	$MenuMusic.play()



func _on_PlayButton_pressed():
	print("pressed")
	queue_free()
	get_tree().get_root().add_child(_gameplay_scene.instance())
