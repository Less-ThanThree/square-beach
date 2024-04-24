extends Node

class_name Unit

@export var health: int = 100
@export var movement_speed: float = 0.1
@export var attack_damage: int = 5
@export var attack_speed: int = 1
@export var attack_range: int = 1
@export var mana_cost: int = 1
@export var word_spell: String

var state

func take_damage(damage: int):
	health -= damage

func move_to():
	var new_vector = Vector3(self.position.x + movement_speed, self.position.y, self.position.z)
	self.position = new_vector
