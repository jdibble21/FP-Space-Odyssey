extends KinematicBody2D


signal destroyed
const SPEED := 250

export (PackedScene) var Bullet 

var _fire_delay := 1
var _disable_hitbox := false
var _powerup_released := false
var _time_elapsed := 0.0
var _current_scene_name := ""

func _ready():
	$AnimatedSprite.play("active")
	_current_scene_name = get_parent().name
	
	
func _process(delta):
	_time_elapsed += delta
	if int(_time_elapsed) == _fire_delay:
		_firing_control()
		_time_elapsed = 0.0
	position += transform.y * SPEED * delta
	if position.y >= 805:
		queue_free()

func _firing_control():
	for i in range(0,2):
		var timer = Timer.new()
		timer.set_wait_time(0.1)
		add_child(timer)
		timer.start()
		_fire()
		yield(timer, "timeout")

func _fire():
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node(_current_scene_name)
	root_attach.add_child(b)
	b.transform = $Muzzle.global_transform


func _on_HitBox_area_entered(area):
	if area.is_in_group("player_bullet") and !_disable_hitbox:
		_disable_hitbox = true
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
