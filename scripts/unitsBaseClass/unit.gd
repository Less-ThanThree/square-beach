extends Node

class_name Unit

@export var health: int = 100
@export var movement_speed: int = 1
@export var attack_damage: int = 5
@export var attack_speed: int = 1
@export var attack_range: int = 1
@export var mana_cost: int = 1
@export var word_spell: String

func take_damage(damage: int):
	health -= damage

func move_to(vector: Vector3):
	pass
