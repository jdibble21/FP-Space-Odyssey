# Controls five separate sprite velocities for level one boss special attack
extends Node

const SPEED := 250
const LOW_SPEED := 150

onready var _particle_one := $ParticleOne
onready var _particle_two := $ParticleTwo
onready var _particle_three := $ParticleThree
onready var _particle_four := $ParticleFour
onready var _particle_five := $ParticleFive


func _process(delta):
	# Each particle fired in a unique but symmetrical direction
	_particle_one.position += _particle_one.transform.y * SPEED * delta
	_particle_one.position += _particle_one.transform.x * SPEED * delta
	_particle_two.position -= _particle_two.transform.x * SPEED * delta
	_particle_two.position += _particle_two.transform.y * SPEED * delta
	_particle_three.position += _particle_three.transform.x * LOW_SPEED * delta
	_particle_three.position += _particle_three.transform.y * SPEED * delta
	_particle_four.position -= _particle_four.transform.x * LOW_SPEED * delta
	_particle_four.position += _particle_four.transform.y * SPEED * delta
	_particle_five.position += _particle_five.transform.y * SPEED * delta
