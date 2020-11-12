# Handles physics of enemy standard attack. Will trigger player to
# be hit on area contact
extends Area2D

const SPEED := 200

func _ready():
	$AnimatedSprite.play("active")
	$FiringSound.play()


func _process(delta):
	position += transform.y * SPEED * delta
	if position.y >= 800:
		queue_free()
		

func _on_EnemyStandardBullet_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
