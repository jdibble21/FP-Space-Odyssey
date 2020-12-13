extends KinematicBody2D

signal destroyed

const SPEED := 70

export (PackedScene) var Bullet
var _fire_delay := randi()%6+3
var _time_elapsed := 0.0
var _current_scene_name
var _lives := 2

func _ready():
	$Exhaust1.play("active")
	$Exhaust2.play("active")
	$AnimatedSprite.play("active")
	_current_scene_name = get_parent().name
	print(_current_scene_name)
	
func _process(delta):
	_time_elapsed += delta
	if int(_time_elapsed) >= _fire_delay:
		_fire()
		_time_elapsed = 0.0
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
		
		
func _fire():
	var b = Bullet.instance()
	var root_attach = get_tree().get_root().get_node(_current_scene_name)
	root_attach.add_child(b)
	b.transform = $Muzzle.global_transform


func _on_HitBox_area_entered(area):
	if area.is_in_group("player_bullet"):
		_lives -= 1
		if _lives == 0:
			$Muzzle/Sprite.hide()
			$Exhaust1.hide()
			$Exhaust2.hide()
			$AnimatedSprite.play("destroyed")
			var timer = Timer.new()
			timer.set_wait_time(0.3)
			add_child(timer)
			timer.start()
			yield(timer, "timeout")
			emit_signal("destroyed")
			queue_free()
