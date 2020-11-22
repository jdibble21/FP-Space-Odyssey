# Controls player movement and firing, as well as sprite
# animations
extends KinematicBody2D

signal cheats_enabled
signal player_hit
signal player_defeated
signal enemy_destroyed

export (PackedScene) var Bullet
export (PackedScene) var PlasmaBullet
export var velocity := 600
export var sideways_velocity := 500

var current_pos := Vector2()
var _screen_size
var powerups_collected := 0
var player_lives := 2
var _plasma_bullet_powerup_active := false
var _current_special_muzzle := 0
var _auto_fire_timer := 0.0 

func _ready():
	_screen_size = get_viewport_rect().size
	$ShipSprite.play("normal")
	$ShipExhaustSprite.play("active")
  

func _process(delta):
	_auto_fire_timer += delta
	if Input.is_action_pressed("fire") and _plasma_bullet_powerup_active:
		if _auto_fire_timer >= 0.1:
			_fire_auto_plasma()
			_auto_fire_timer = 0.0
	if Input.is_action_just_pressed("fire") and !_plasma_bullet_powerup_active:
		_fire()
	if Input.is_action_just_pressed("cheats"):
		_activate_cheats()
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
	var first_b = Bullet.instance()
	first_b.connect("hit_enemy",self,"_on_enemy_destroyed")
	owner.add_child(first_b)
	first_b.transform = $Muzzle.global_transform
	

func _fire_auto_plasma():
	$PlasmaShotSound.play()
	var b = PlasmaBullet.instance()
	b.connect("hit_enemy",self,"_on_enemy_destroyed")
	owner.add_child(b)
	b.transform = $SpecialMuzzleOne.global_transform
	var a = PlasmaBullet.instance()
	a.connect("hit_enemy",self,"_on_enemy_destroyed")
	owner.add_child(a)
	a.transform = $SpecialMuzzleTwo.global_transform
	

func _on_HitBox_hit(area):
	if area.is_in_group("plasma_powerup") and !area.is_in_group("used"):
		powerups_collected += 1
		_plasma_bullet_powerup_active = true
		$SpecialAttackTimer.start()
	if area.is_in_group("health_powerup") and !area.is_in_group("used"):
		powerups_collected += 1
		player_lives += 1
	if area.is_in_group("hazard"):
		emit_signal("player_hit")
		$AnimationPlayer.play()
		player_lives -= 1
		if player_lives < 0:
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
		
		
func _activate_cheats():
	print("CHEATS ENABLED")
	emit_signal("cheats_enabled")
	_plasma_bullet_powerup_active = true
	player_lives = 100000
	
	
func _on_enemy_destroyed():
	emit_signal("enemy_destroyed")


func _on_SpecialAttackTimer_timeout():
	_plasma_bullet_powerup_active = false
