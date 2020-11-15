extends Area2D

const SPEED := 240

func _ready():
	$FiringSound.play()


func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()


func _on_PhotonSingleBullet_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
