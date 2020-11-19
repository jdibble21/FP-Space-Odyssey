extends StaticBody2D

const SPEED := 100

func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("player") and !area.is_in_group("used"):
		$PickupSound.play()
		$Sprite.hide()
		add_to_group("used")


func _on_PickupSound_finished():
	queue_free()
