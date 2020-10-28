extends Area2D

const SPEED := 650

func _physics_process(delta):
	position += transform.y * -SPEED * delta
	if position.y <= 0:
		queue_free()
