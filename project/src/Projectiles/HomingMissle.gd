extends Area2D

export var speed := 300
export var steer_force := 85.0

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO
var target
	
	
func start(_transform, _target):
	global_transform = _transform
	rotation += rand_range(-0.09, 0.09)
	velocity = transform.x * speed
	target = _target


func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer


func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta


func _on_Lifetime_timeout():
	explode()
	
	
func _on_HomingMissle_area_entered(area):
	if area.is_in_group("player"):
		explode()


func explode():
	$Particles2D.emitting = false
	$Sprite.hide()
	$ExplosionSprite.play("destroyed")
	set_physics_process(false)
	print("missle exploded!")


func _on_ExplosionSprite_animation_finished():
	queue_free()
