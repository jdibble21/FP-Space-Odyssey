# Handles menu animation and loading the gameplay scenes on
# button press
extends CanvasLayer

const SPEED := 200
var _selected_level := "empty"

onready var _level_one_scene = load("res://src/LevelOne/LevelOne.tscn")
onready var _level_two_scene = load("res://src/LevelTwo/LevelTwo.tscn")
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
	_selected_level = "level_one"
	$AnimationPlayer.play("transition")

func _on_LevelTwoButton_pressed():
	_selected_level = "level_two"
	$AnimationPlayer.play("transition")
	
func _on_PlayBackButton_pressed():
	$LevelSelectPanel.hide()


func _on_OptionsButton_pressed():
	$OptionsPanel.show()


func _on_transition_animation_finished(anim_name):
	if anim_name == "backwards_transition" and _selected_level == "empty":
		$AnimationPlayer.play("logo_animation")
	if anim_name == "transition" and _selected_level == "level_one":
		queue_free()
		get_tree().get_root().add_child(_level_one_scene.instance())
	if anim_name == "transition" and _selected_level == "level_two":
		queue_free()
		get_tree().get_root().add_child(_level_two_scene.instance())


func _on_MainMenu_tree_entered():
	$AnimationPlayer.play("backwards_transition")



