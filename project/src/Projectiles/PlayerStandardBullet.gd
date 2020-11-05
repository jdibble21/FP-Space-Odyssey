# Controls regular player attack movement and hit detection
extends Area2D

const SPEED := 650

func _physics_process(delta):
	position += transform.y * -SPEED * delta
	if position.y <= 0:
		queue_free()


func _on_PlayerStandardBullet_area_entered(area):
	if area.is_in_group("enemy_ship"):
		queue_free()
