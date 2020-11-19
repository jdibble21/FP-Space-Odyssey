# Detects when player enters powerup area, plays collect sound
# and deletes itself
extends Area2D

func _on_LifePowerUp_area_entered(area):
	if area.is_in_group("player"):
		$PickupSound.play()
		queue_free()
