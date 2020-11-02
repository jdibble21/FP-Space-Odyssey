extends Area2D

const SPEED := 200


func _ready():
	pass # Replace with function body.

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()

