# Contains boss health, timers for attacks, movement parameters, 
# destroyed animation and defeat signal
extends KinematicBody2D

signal boss_defeated

const SPEED := 60

export (PackedScene) var StandardBullet
export (PackedScene) var PhotonBullet
export (int) var total_health := 100

var _travel_right := true
var _stop_yaxis_travel := false
var current_muzzle

onready var _current_health = total_health
onready var _muzzle_one = $Muzzle1
onready var _muzzle_two = $Muzzle2
onready var _muzzle_three = $Muzzle3
onready var _muzzle_four = $Muzzle4

func _ready():
	_hide_sprites()
	set_process(false)
	$HitBox.hide()
	position = Vector2(350,-100)
	$ExhaustOne.play("active")
	$ExhaustTwo.play("active")
	
	
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
	for _j in range(0,2):
		for i in range(0,4):
			var timer = Timer.new()
			timer.set_wait_time(0.1)
			add_child(timer)
			timer.start()
			if i+1 == 1:
				current_muzzle = _muzzle_one
			if i+1 == 2:
				 current_muzzle = _muzzle_two
			if i+1 == 3:
				current_muzzle = _muzzle_three
			if i+1 == 4:
				current_muzzle = _muzzle_four
			_fire_standard_bullet()
			yield(timer, "timeout")
	
	
func _fire_standard_bullet():
	var b = StandardBullet.instance()
	var root_attach = get_tree().get_root().get_node("LevelOne")
	root_attach.add_child(b)
	b.transform = current_muzzle.global_transform
	

func _on_SpecialAttackDelay_timeout():
	var b = PhotonBullet.instance()
	var root_attach = get_tree().get_root().get_node("LevelOne")
	root_attach.add_child(b)
	$SpecialAttackSound.play()
	b.transform = $MuzzleSpecial.global_transform


func _on_HitBox_area_entered(area):
	if area.is_in_group("player_bullet"):
		_current_health -= 4
		
		
func _hide_sprites():
	$AnimatedSprite.hide()
	$AnimatedSprite2.hide()
	$AnimatedSprite3.hide()
	$AnimatedSprite4.hide()
	$AnimatedSprite5.hide()
	
	
func _activate_destruction():
	$AnimatedSprite.show()
	$AnimatedSprite2.show()
	$AnimatedSprite3.show()
	$AnimatedSprite4.show()
	$AnimatedSprite5.show()
	$AnimatedSprite/Time1.start()
	$AnimatedSprite2/Time2.start()
	$AnimatedSprite3/Time3.start()
	$AnimatedSprite4/Time4.start()
	$AnimatedSprite5/Time5.start()
	
	
func _on_defeat():
	set_process(false)
	$ExhaustOne.hide()
	$ExhaustTwo.hide()
	$StandardAttackDelay.stop()
	$SpecialAttackDelay.stop()
	var timer = Timer.new()
	timer.set_wait_time(3)
	$DestroyedSound.play()
	add_child(timer)
	timer.start()
	_activate_destruction()
	yield(timer, "timeout")
	$DestroyedSound.stop()
	emit_signal("boss_defeated")


func _on_Time1_timeout():
	$AnimatedSprite.play("destroyed")


func _on_Time2_timeout():
	$AnimatedSprite2.play("destroyed")


func _on_Time3_timeout():
	$AnimatedSprite3.play("destroyed")


func _on_Time4_timeout():
	$AnimatedSprite4.play("destroyed")


func _on_Time5_timeout():
	$AnimatedSprite5.play("destroyed")
