extends CanvasLayer


func _ready():
	$ShipSprite/ShipExhaust.play("active")
	$MenuMusic.play()

