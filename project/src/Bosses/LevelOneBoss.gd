extends KinematicBody2D

const SPEED := 60

export (PackedScene) var StandardBullet
export (PackedScene) var PhotonBullet

var _travel_right := true
var _stop_yaxis_travel := false
var current_muzzle

onready var _muzzle_one = $Muzzle1
onready var _muzzle_two = $Muzzle2
onready var _muzzle_three = $Muzzle3
onready var _muzzle_four = $Muzzle4

func _ready():
	position = Vector2(350,-100)
	$ExhaustOne.play("active")
	$ExhaustTwo.play("active")
	
	
func _process(delta):
	if !_stop_yaxis_travel:
		position += transform.y * SPEED * delta
		if position.y >= 120:
			_stop_yaxis_travel = true
		return
	if _travel_right:
		#position += transform.y * SPEED * delta
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
