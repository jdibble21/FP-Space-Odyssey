# Handles pausing the game while keeping this node active
# to listen for resume button press or exit to menu press
# and executing accordingly 
extends CanvasLayer

onready var _menu_scene = load("res://src/Menu.tscn")

func _on_ResumeButton_pressed():
	$PausePanel.hide()
	get_tree().paused = false


func _on_ReturnMenuButton_pressed():
	print(get_parent())
	get_tree().paused = false
	get_parent().queue_free()
	queue_free()
	get_tree().get_root().add_child(_menu_scene.instance())
