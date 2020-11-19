extends StaticBody2D



func _ready():
	pass # Replace with function body.




func _on_Area2D_area_entered(area):
	if area.is_in_group("player") and !area.is_in_group("used"):
		print("player entered!")
		$PickupSound.play()
		$Sprite.hide()
		add_to_group("used")
