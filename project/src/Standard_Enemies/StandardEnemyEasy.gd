extends KinematicBody2D

const SPEED := 40

export (PackedScene) var Bullet 
var _fire_delay := randi()%7+3
var _can_fire := true

func _ready():
	_fire()
	pass # Replace with function body.
	
func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
	


func _fire():
	print("Firing")
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node(".")
	root_attach.add_child(b)
	b.transform = $Muzzle.global_transform
