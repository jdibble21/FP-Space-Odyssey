extends KinematicBody2D

export var velocity := 600
export var sideways_velocity := 500
var _current_pos := Vector2()

func _ready():
	$ShipSprite.play("normal")

func _process(delta):
	if Input.is_action_just_pressed("fire"):
		print("firing!")
	if Input.is_action_pressed("move_left") and position.x > -479:
		_current_pos.x -= sideways_velocity * delta
		$ShipSprite.play("turning")
		$ShipSprite.flip_h = false
	if Input.is_action_pressed("move_right") and position.x < 509:
		_current_pos.x += sideways_velocity * delta
		$ShipSprite.play("turning")
		$ShipSprite.flip_h = true
	if Input.is_action_pressed("move_up"):
		_current_pos.y -= velocity * delta
	if Input.is_action_pressed("move_down"):
		_current_pos.y += velocity * delta
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		$ShipSprite.play("normal")
	position = _current_pos
