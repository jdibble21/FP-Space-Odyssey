extends KinematicBody2D

const SPEED := 40

var _fire_delay := randi()%7+3
var _can_fire := true

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
