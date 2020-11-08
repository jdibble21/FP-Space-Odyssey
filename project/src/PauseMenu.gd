extends CanvasLayer


onready var _menu_scene = load("res://src/Menu.tscn")

func _on_ResumeButton_pressed():
	$PausePanel.hide()
	get_tree().paused = false


func _on_ReturnMenuButton_pressed():
	queue_free()
	get_tree().get_root().add_child(_menu_scene.instance())
