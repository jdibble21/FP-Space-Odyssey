# Controls boss for level two. Movement, firing delays, updating health
# and defeat signals are all tracked
extends KinematicBody2D

signal boss_defeated

const SPEED := 60

export (PackedScene) var StandardBullet
export (PackedScene) var Missle
var _travel_right := true
var _stop_yaxis_travel := false
var current_muzzle
var _current_scene_name

onready var _muzzle_one := $Muzzle1
onready var _muzzle_two := $Muzzle2
onready var _muzzle_rocket := $Muzzle3
onready var _current_health := 100

func _ready():
	_current_scene_name = get_parent().name
	$HitBox.hide()
	set_process(false)
	position = Vector2(350,-100)
	$Exhaust1.play("active")
	$Exhaust2.play("active")
	
	
func _process(delta):
	$HealthBar.value = _current_health
	if _current_health == 0:
		_on_defeat()
	if !_stop_yaxis_travel:
		position += transform.y * SPEED * delta
		if position.y >= 140:
			_stop_yaxis_travel = true
		return
	if _travel_right:
		position += transform.x * SPEED * delta
		if position.x >= 650:
			_travel_right = false
	if !_travel_right:
		position -= transform.x * SPEED * delta
		if position.x <= 50:
			_travel_right = true


func _on_StandardAttackDelay_timeout():
	for _j in range(0,3):
		for i in range(0,2):
			var timer = Timer.new()
			timer.set_wait_time(0.1)
			add_child(timer)
			timer.start()
			if i+1 == 1:
				current_muzzle = _muzzle_one
			if i+1 == 2:
				 current_muzzle = _muzzle_two
			_fire_plasma_bullet()
			yield(timer, "timeout")
			
			
func _on_MissleAttackDelay_timeout():
	_fire_missle()
	
			
func _fire_missle():
	var m = Missle.instance()
	var root_attach = get_tree().get_root().get_node("LevelTwo")
	root_attach.add_child(m)
	var target = get_parent().get_node("Player")
	m.start(_muzzle_rocket.global_transform,target)
			
			
func _fire_plasma_bullet():
	var b = StandardBullet.instance()
	var root_attach = get_tree().get_root().get_node(_current_scene_name)
	root_attach.add_child(b)
	b.transform = current_muzzle.global_transform


func _on_defeat():
	set_process(false)
	$Exhaust1.hide()
	$Exhaust2.hide()
	$StandardAttackDelay.stop()
	$MissleAttackDelay.stop()
	var timer = Timer.new()
	timer.set_wait_time(3)
	$DestroyedSound.play()
	add_child(timer)
	timer.start()
	_activate_destruction()
	yield(timer, "timeout")
	$DestroyedSound.stop()
	emit_signal("boss_defeated")


func _hide_sprites():
	$ExplosionSprite1.hide()
	$ExplosionSprite2.hide()
	$ExplosionSprite3.hide()
	$ExplosionSprite4.hide()
	$ExplosionSprite5.hide()


func _activate_destruction():
	$ExplosionSprite1.show()
	$ExplosionSprite2.show()
	$ExplosionSprite3.show()
	$ExplosionSprite4.show()
	$ExplosionSprite5.show()
	$ExplosionSprite1/Timer1.start()
	$ExplosionSprite2/Timer2.start()
	$ExplosionSprite3/Timer3.start()
	$ExplosionSprite4/Timer4.start()
	$ExplosionSprite5/Timer5.start()
	
	
func _on_HitBox_area_entered(area):
	if area.is_in_group("player_bullet"):
		_current_health -= 2
		

func _on_Timer_timeout():
	$ExplosionSprite1.play("destroyed")


func _on_Timer2_timeout():
	$ExplosionSprite2.play("destroyed")


func _on_Timer3_timeout():
	$ExplosionSprite3.play("destroyed")


func _on_Timer4_timeout():
	$ExplosionSprite4.play("destroyed")
	

func _on_Timer5_timeout():
	$ExplosionSprite5.play("destroyed")
