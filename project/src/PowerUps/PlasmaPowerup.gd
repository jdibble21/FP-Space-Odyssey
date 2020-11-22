# Controls powerup downward movement, and detects when player enters area, then 
# plays pickup sound and hides sprite
extends StaticBody2D

const SPEED := 100

var _used := false

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("player") and !_used:
		print("picked up plasma!")
		_used = true
		$PickupSound.play()
		$Sprite.hide()
		

func _on_PickupSound_finished():
	queue_free()
