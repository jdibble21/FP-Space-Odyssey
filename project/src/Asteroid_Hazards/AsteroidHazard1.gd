extends RigidBody2D

signal hit_player

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("active")
	var animation = $AnimationPlayer.get_animation("active")
	animation.set_loop(true)
