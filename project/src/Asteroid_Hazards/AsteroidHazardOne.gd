extends Area2D

const SPEED := 100

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 250
	$AnimationPlayer.play("active")

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
