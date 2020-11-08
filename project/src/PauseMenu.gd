extends CanvasLayer


onready var _menu_scene = preload("res://src/Menu.tscn")

func _on_ResumeButton_pressed():
	$PausePanel.hide()
	get_tree().paused = false


func _on_ReturnMenuButton_pressed():
	get_parent().queue_free()
	get_tree().paused = false
	queue_free()
	get_tree().get_root().add_child(load("res://src/Menu.tscn").instance())
