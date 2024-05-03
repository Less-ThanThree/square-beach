extends Node

@onready var tron_anim = $TronAnim

@export var is_enemy_tron = false
#@onready var tron_active = $TronActive
#@onready var tron_destroy = $TronDestory
#@onready var tron_boom = $AnimatedDestory

func _ready():
	if is_enemy_tron:
		tron_anim.play("idle_enemie")
	else:
		tron_anim.play("idle_player")

func on_tron_destroy():
	if is_enemy_tron:
		tron_anim.play("destory_enemie")
	else:
		tron_anim.play("destroy_player")
