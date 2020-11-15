extends KinematicBody2D

const SPEED := 80

export (PackedScene) var Bullet

var _current_muzzle
var _fire_delay := randi()%4+1
var _time_elapsed := 0.0

onready var _muzzle_one = $Muzzle1
onready var _muzzle_two = $Muzzle2

func _ready():
	$Exhaust1.play("active")
	$Exhaust2.play("active")


func _process(delta):
	_time_elapsed += delta
	if int(_time_elapsed) >= _fire_delay:
		_firing_control()
		_time_elapsed = 0.0
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
		
		
func _firing_control():
	for i in range(0,2):
		print("firing at muzzle" + str(i+1))
		var timer = Timer.new()
		timer.set_wait_time(0.1)
		add_child(timer)
		timer.start()
		if i+1 == 1:
			_current_muzzle = _muzzle_one
		if i+1 == 2:
			_current_muzzle = _muzzle_two
		_fire()
		yield(timer, "timeout")
	
	
func _fire():
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node("LevelOne")
	root_attach.add_child(b)
	b.transform = _current_muzzle.global_transform