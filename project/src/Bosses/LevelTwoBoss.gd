extends KinematicBody2D

signal boss_defeated

const SPEED := 60

export (PackedScene) var StandardBullet
export (PackedScene) var Missle
var _travel_right := true
var _stop_yaxis_travel := false
var current_muzzle

onready var _muzzle_one := $Muzzle1
onready var _muzzle_two := $Muzzle2
onready var _muzzle_rocket := $Muzzle3
onready var _current_health := 100

func _ready():
	$HitBox.hide()
	position = Vector2(350,-100)
	$Exhaust1.play("active")
	$Exhaust2.play("active")
	
	
func _process(delta):
	$HealthBar.value = _current_health
	if _current_health == 0:
		#defeat
		pass
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
	var root_attach = get_tree().get_root().get_node("LevelTwo")
	root_attach.add_child(b)
	b.transform = current_muzzle.global_transform



