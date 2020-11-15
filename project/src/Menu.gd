# Handles menu animation and loading the gameplay scenes on
# button press
extends CanvasLayer

const SPEED := 200

onready var _level_one_scene = load("res://src/LevelOne/LevelOne.tscn")

func _ready():
	$MenuMusic.play()
	$BossShip/Exhaust1.play("active")
	$BossShip/Exhaust2.play("active")
	$LevelSelectPanel.hide()
	$OptionsPanel.hide()


func _on_PlayButton_pressed():
	$LevelSelectPanel.show()


func _on_SpriteFlyByTimer_timeout():
	$AnimationPlayer.play("flyby")
	#yield(get_node("AnimationPlayer"), "animation_finished")
	#$AnimationPlayer.play("boss_ship")
	yield(get_node("AnimationPlayer"),"animation_finished")
	pass



func _on_LevelOneButton_pressed():
	queue_free()
	get_tree().get_root().add_child(_level_one_scene.instance())


func _on_PlayBackButton_pressed():
	$LevelSelectPanel.hide()


func _on_OptionsButton_pressed():
	$OptionsPanel.show()


func _on_OptionsBackButton_pressed():
	$OptionsPanel.hide()
