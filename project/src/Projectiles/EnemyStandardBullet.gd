extends Area2D

const SPEED := 200


func _ready():
	$AnimatedSprite.play("active")

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()

