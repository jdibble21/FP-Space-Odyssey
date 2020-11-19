# Handles powerup movement, detects when player enters powerup area, 
# plays collect sound and deletes itself
extends Area2D

const SPEED := 100

func _on_LifePowerUp_area_entered(area):
	if area.is_in_group("player"):
		$PickupSound.play()
		queue_free()
		
func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
