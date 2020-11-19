# Controls movement, and random firing delay for enemy type. 
extends KinematicBody2D

signal destroyed
const SPEED := 60

export (PackedScene) var Bullet 
export (PackedScene) var HealthPowerup
export (PackedScene) var AttackPowerup

var _initial_fire_delay := randi()%6+1
var _fire_delay := randi()%8+2
var _powerup_drop_chance := randi()%3+1
var _time_elapsed := 0.0

func _ready():
	connect("destroyed",self,"_check_powerup_drop")
	$AnimatedSprite.play("normal")
	
	
func _process(delta):
	_time_elapsed += delta
	if int(_time_elapsed) == _fire_delay:
		_fire()
		_time_elapsed = 0.0
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
	

func _fire():
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node("LevelOne")
	root_attach.add_child(b)
	b.transform = $Muzzle.global_transform
	

func _on_HitBox_area_entered(area):
	if area.is_in_group("player_bullet"):
		$AnimatedSprite.play("destroyed")
		$DestroyedSound.play()
		$Muzzle/Sprite.hide()
		emit_signal("destroyed")
		var timer = Timer.new()
		timer.set_wait_time(0.3)
		add_child(timer)
		timer.start()
		yield(timer, "timeout")
		queue_free()
		
func _check_powerup_drop():
	if _powerup_drop_chance == 2:
		var power_up = HealthPowerup.instance()
		power_up.position = self.position
		print("DROPPING POWERUP")
		var root_attach = get_tree().get_root().get_node("LevelOne")
		root_attach.call_deferred("add_child",power_up)
		#root_attach.add_child(power_up)

