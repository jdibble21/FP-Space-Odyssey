# Handles menu animation and loading the gameplay scenes on
# button press
extends CanvasLayer

const SPEED := 200

onready var _gameplay_scene = load("res://src/LevelOne/LevelOne.tscn")

func _ready():
	$MenuMusic.play()
	$BossShip/Exhaust1.play("active")
	$BossShip/Exhaust2.play("active")


func _on_PlayButton_pressed():
	queue_free()
	get_tree().get_root().add_child(_gameplay_scene.instance())


func _on_SpriteFlyByTimer_timeout():
	
	$AnimationPlayer.play("flyby")
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("boss_ship")
	yield(get_node("AnimationPlayer"),"animation_finished")
	pass



