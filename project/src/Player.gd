extends KinematicBody2D

export (PackedScene) var Bullet

export var velocity := 600
export var sideways_velocity := 500
var current_pos := Vector2()
var _screen_size

func _ready():
	_screen_size = get_viewport_rect().size
	$ShipSprite.play("normal")
	$ShipExhaustSprite.play("active")
  

func _process(delta):
	if Input.is_action_just_pressed("fire"):
		_fire()
	if Input.is_action_pressed("move_left"):
		current_pos.x -= sideways_velocity * delta
		$ShipSprite.play("turning")
		$ShipSprite.flip_h = false
	if Input.is_action_pressed("move_right"):
		current_pos.x += sideways_velocity * delta
		$ShipSprite.play("turning")
		$ShipSprite.flip_h = true
	if Input.is_action_pressed("move_up"):
		current_pos.y -= velocity * delta
	if Input.is_action_pressed("move_down"):
		current_pos.y += velocity * delta
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		$ShipSprite.play("normal")
	position = current_pos
	
func _fire():
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
