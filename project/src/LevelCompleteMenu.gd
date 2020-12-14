# Panel that appears at the end of a level, with stats about the session and 
# options to replay or go back to menu
extends CanvasLayer

var _current_scene

onready var _level_one_scene = load("res://src/LevelOne/LevelOne.tscn")
onready var _level_two_scene = load("res://src/LevelTwo/LevelTwo.tscn")
onready var _menu_scene = load("res://src/Menu.tscn")

func _ready():
	if str(self.get_parent().name) == "LevelOne":
		_current_scene = _level_one_scene
	if str(self.get_parent().name) == "LevelTwo":
		_current_scene = _level_two_scene	
		$CompletePanel/NextLevelButton.hide()
	$CompletePanel.hide()


func _on_ReplayLevelButton_pressed():
	get_parent().queue_free()
	queue_free()
	get_tree().get_root().add_child(_current_scene.instance())


func _on_NextLevelButton_pressed():
	get_parent().queue_free()
	queue_free()
	get_tree().get_root().add_child(_level_two_scene.instance())


func _on_ReturnMenuButton_pressed():
	get_parent().queue_free()
	queue_free()
	get_tree().get_root().add_child(_menu_scene.instance())
