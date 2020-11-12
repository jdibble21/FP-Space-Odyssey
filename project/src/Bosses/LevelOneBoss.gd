extends KinematicBody2D

const SPEED := 60

export (PackedScene) var StandardBullet
export (PackedScene) var PhotonBullet

var _travel_right := true
var current_muzzle

onready var _muzzle_one = $Muzzle1
onready var _muzzle_two = $Muzzle2
onready var _muzzle_three = $Muzzle3
onready var _muzzle_four = $Muzzle4

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass
	if _travel_right:
		#position += transform.y * SPEED * delta
		position += transform.x * SPEED * delta
		if position.x >= 700:
			_travel_right = false
	if !_travel_right:
		position -= transform.x * SPEED * delta
		if position.x <= 0:
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
	# change to actual root
	var root_attach = get_tree().get_root().get_node("LevelOne")
	root_attach.add_child(b)
	b.transform = current_muzzle.global_transform
	
