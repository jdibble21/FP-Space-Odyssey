# Handles menu animation and loading the gameplay scenes on
# button press
extends CanvasLayer

const SPEED := 200

onready var _level_one_scene = load("res://src/LevelOne/LevelOne.tscn")
onready var _music_bus = AudioServer.get_bus_index("Music")
onready var _sfx_bus = AudioServer.get_bus_index("SFX")

func _ready():
	$MenuMusic.play()
	$LevelSelectPanel.hide()
	$OptionsPanel.hide()
	AudioServer.set_bus_volume_db(_music_bus,-8.0)
	AudioServer.set_bus_volume_db(_sfx_bus,-8.0)


func _on_PlayButton_pressed():
	$LevelSelectPanel.show()


func _on_SpriteFlyByTimer_timeout():
	$AnimationPlayer.play("flyby")


func _on_LevelOneButton_pressed():
	$AnimationPlayer.play("transition")


func _on_PlayBackButton_pressed():
	$LevelSelectPanel.hide()


func _on_OptionsButton_pressed():
	$OptionsPanel.show()


func _on_transition_animation_finished(anim_name):
	if anim_name == "transition":
		queue_free()
		get_tree().get_root().add_child(_level_one_scene.instance())
