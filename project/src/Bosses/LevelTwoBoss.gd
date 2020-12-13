extends KinematicBody2D

signal boss_defeated

const SPEED := 60

var _travel_right := true
var _stop_yaxis_travel := false
var current_muzzle

onready var _muzzle_one := $Muzzle1
onready var _muzzle_two := $Muzzle2
onready var _muzzle_rocket := $Muzzle3
onready var _current_health := 100

func _ready():
	$HitBox.hide()
	position = Vector2(350,-100)
	$Exhaust1.play("active")
	$Exhaust2.play("active")
	
func _process(delta):
	$HealthBar.value = _current_health
	if _current_health == 0:
		#defeat
		pass
	if !_stop_yaxis_travel:
		position += transform.y * SPEED * delta
		if position.y >= 140:
			_stop_yaxis_travel = true
		return
	if _travel_right:
		position += transform.x * SPEED * delta
		if position.x >= 650:
			_travel_right = false
	if !_travel_right:
		position -= transform.x * SPEED * delta
		if position.x <= 50:
			_travel_right = true


