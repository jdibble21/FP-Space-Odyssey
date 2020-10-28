extends KinematicBody2D

const SPEED := 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
