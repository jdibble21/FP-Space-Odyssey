# Controls movement, and random firing delay for enemy type. 
# IGNORED WARNINGS:
# connect() warning returns a value I do not need or use, so warning is not needed
extends KinematicBody2D

signal destroyed
const SPEED := 105

export (PackedScene) var Bullet 
export (PackedScene) var HealthPowerup
export (PackedScene) var PlasmaAttackPowerup

var _initial_fire_delay := randi()%6+1
var _fire_delay := randi()%8+2
var _powerup_drop_chance := randi()%12+1
var _powerup_released := false
var _time_elapsed := 0.0
var current_scene_name := ""

func _ready():
# warning-ignore:return_value_discarded
	connect("destroyed",self,"_check_powerup_drop")
	$AnimatedSprite.play("normal")
	current_scene_name = get_parent().name
	
	
func _process(delta):
	_time_elapsed += delta
	if int(_time_elapsed) == _fire_delay:
		_fire()
		_time_elapsed = 0.0
	position += transform.y * SPEED * delta
	if position.y >= 805:
		queue_free()
	

func _fire():
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node(current_scene_name)
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
	if _powerup_drop_chance == 2 and !_powerup_released:
		_powerup_released = true
		var power_up = HealthPowerup.instance()
		power_up.position = self.position
		var root_attach = get_tree().get_root().get_node(current_scene_name)
		root_attach.call_deferred("add_child",power_up)
	if _powerup_drop_chance == 3 and !_powerup_released:
		_powerup_released = true
		var power_up = PlasmaAttackPowerup.instance()
		power_up.position = self.position
		var root_attach = get_tree().get_root().get_node(current_scene_name)
		root_attach.call_deferred("add_child",power_up)
		

