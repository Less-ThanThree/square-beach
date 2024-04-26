extends Node

@onready var tron_active = $TronActive
@onready var tron_destroy = $TronDestory
@onready var tron_boom = $AnimatedDestory

func on_tron_destroy():
	tron_boom.visible = true
	tron_boom.play("destory")
	tron_active.visible = false
	tron_destroy.visible = true
