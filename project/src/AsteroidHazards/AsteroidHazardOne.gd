# Asteroid hazard that spawns randomly on the x axis via the level scripts off
# a timer
extends Area2D

const SPEED := 80

onready var _sprite_image := randi()%3+1

func _ready():
	$Sprite.hide()
	$Sprite2.hide()
	$Sprite3.hide()
	position.x = randi()%670+30
	$AnimationPlayer.play("active")
	if _sprite_image == 1:
		$Sprite.show()
	if _sprite_image == 2:
		$Sprite2.show()
	if _sprite_image == 3:
		$Sprite3.show()

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
