extends KinematicBody2D


signal destroyed
const SPEED := 250

export (PackedScene) var Bullet 

var _fire_delay := randi()%3+2
var _disable_hitbox := false
var _powerup_released := false
var _time_elapsed := 0.0
var current_scene_name := ""
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("active")
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
	pass
