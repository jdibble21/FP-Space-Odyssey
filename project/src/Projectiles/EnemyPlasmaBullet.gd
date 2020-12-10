extends Area2D

const SPEED := 350

func _ready():
	$FiringSound.play()


func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
