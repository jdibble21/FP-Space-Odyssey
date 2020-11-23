# Handles pausing the game while keeping this node active
# to listen for resume button press or exit to menu press
# and executing accordingly 
extends CanvasLayer

onready var _menu_scene = load("res://src/Menu.tscn")

func _ready():
	$OptionsPanel.hide()
	
	
func _on_ResumeButton_pressed():
	$PausePanel.hide()
	get_tree().paused = false
	

func _on_OptionsButton_pressed():
	$OptionsPanel.show()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "backwards_transition":
		get_parent().queue_free()
		queue_free()
		get_tree().get_root().add_child(_menu_scene.instance())
