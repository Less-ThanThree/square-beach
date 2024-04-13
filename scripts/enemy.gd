extends Node3D

@onready var anim_sprite = $AnimatedSprite

func _ready():
	anim_sprite.play('idle')
