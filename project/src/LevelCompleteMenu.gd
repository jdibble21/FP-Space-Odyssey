# Panel that appears at the end of a level, with stats about the session and 
# options to replay or go back to menu
extends CanvasLayer

onready var _gameplay_scene = load("res://src/LevelOne/LevelOne.tscn")
onready var _menu_scene = load("res://src/Menu.tscn")

func _ready():
	$CompletePanel.hide()
	

func _on_ReturnMenuButton_pressed():
	get_parent().queue_free()
	queue_free()
	get_tree().get_root().add_child(_menu_scene.instance())


func _on_ReplayLevelButton_pressed():
	get_parent().queue_free()
	queue_free()
	get_tree().get_root().add_child(_gameplay_scene.instance())
