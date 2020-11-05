extends Area2D

const SPEED := 80

func _ready():
	position.x = randi()%670+30
	$AnimationPlayer.play("active")

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
