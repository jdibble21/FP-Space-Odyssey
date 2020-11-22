# Controls projectile movement and animated sprite, 
# detects when out of play area to delete self or is in contact with enemy
extends Area2D

signal hit_enemy

const SPEED := 700

func _ready():
	$AnimatedSprite.play("active")
	
func _physics_process(delta):
	position += transform.y * -SPEED * delta
	if position.y <= 0:
		queue_free()


func _on_PlasmaBullet_area_entered(area):
	if (area.is_in_group("enemy_ship") or area.is_in_group("hazard")) and !area.is_in_group("enemy_bullet"):
		emit_signal("hit_enemy")
		queue_free()

