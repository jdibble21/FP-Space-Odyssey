# Controls player movement and firing, as well as sprite
# animations
extends KinematicBody2D

signal player_hit
signal player_defeated
signal enemy_destroyed

export (PackedScene) var Bullet
export var velocity := 600
export var sideways_velocity := 500

var current_pos := Vector2()
var _screen_size
var _player_lives := 1

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
	position.x = clamp(position.x, 0, _screen_size.x)
	position.y = clamp(position.y, 0, _screen_size.y)
	
	
func _fire():
	var b = Bullet.instance()
	b.connect("hit_enemy",self,"_on_enemy_destroyed")
	owner.add_child(b)
	b.transform = $Muzzle.global_transform


func _on_HitBox_hit(area):
	if area.is_in_group("hazard"):
		emit_signal("player_hit")
		print("player hit!!!")
		_player_lives -= 1
		if _player_lives <= 0:
			set_process(false)
			$ShipSprite.play("destroyed")
			$Muzzle/Sprite.hide()
			$ShipExhaustSprite.hide()
			var timer = Timer.new()
			timer.set_wait_time(0.3)
			add_child(timer)
			timer.start()
			yield(timer, "timeout")
			emit_signal("player_defeated")
		
		
func _on_enemy_destroyed():
	emit_signal("enemy_destroyed")
