extends KinematicBody2D

const SPEED := 80

func _ready():
	$Exhaust1.play("active")
	$Exhaust2.play("active")


func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
