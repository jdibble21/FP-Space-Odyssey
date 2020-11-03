extends KinematicBody2D

const SPEED := 40

export (PackedScene) var Bullet 

var _fire_delay := randi()%12+7
var _can_fire := true
var _time_elapsed := 0.0

func _ready():
	pass

	
func _process(delta):
	_time_elapsed += delta
	print(int(_time_elapsed))
	if int(_time_elapsed) == _fire_delay:
		_fire()
		_time_elapsed = 0.0
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
	

func _fire():
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node(".")
	root_attach.add_child(b)
	b.transform = $Muzzle.global_transform
	
