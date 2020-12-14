# Controls enemy movement, hit detection and randomized firing delay
extends KinematicBody2D

signal destroyed

const SPEED := 70

export (PackedScene) var Bullet

var _fire_delay := randi()%6+3
var _time_elapsed := 0.0
var _current_scene_name
var _lives := 2

func _ready():
	$DamagedAnimation.hide()
	$Exhaust1.play("active")
	$Exhaust2.play("active")
	$Sprite.play("active")
	_current_scene_name = get_parent().name
	
	
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
		$DamagedAnimation.show()
		$DamagedAnimation.play("damage")
		if _lives == 0:
			$Muzzle/Sprite.hide()
			$Exhaust1.hide()
			$Exhaust2.hide()
			$Sprite.play("destroyed")
			$DestroyedSound.play()
			var timer = Timer.new()
			timer.set_wait_time(0.3)
			add_child(timer)
			timer.start()
			yield(timer, "timeout")
			emit_signal("destroyed")
			queue_free()


func _on_DamagedAnimation_animation_finished():
	$DamagedAnimation.hide()
