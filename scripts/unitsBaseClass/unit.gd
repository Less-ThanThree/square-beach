extends Node

class_name Unit

signal die

var health: int
var movement_speed: float
var attack_damage: int
var attack_speed: int
var attack_range: int
var mana_cost: int
var word_spell: String
var animation_sprite: AnimatedSprite3D

var state

func take_damage(damage: int):
	health -= damage
	print(health)
	if health < 0:
		die.emit()

func move_to(delta):
	var new_vector = Vector3(self.position.x + (movement_speed * delta), self.position.y, self.position.z)
	self.position = new_vector

func move_to_reverse(delta):
	var new_vector = Vector3(self.position.x - (movement_speed * delta), self.position.y, self.position.z)
	self.position = new_vector

func animation_unit_play(animation, name_anim):
	animation.play(name_anim)
