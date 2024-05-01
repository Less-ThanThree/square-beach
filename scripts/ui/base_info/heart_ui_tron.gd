extends Control

signal heart_blow

@onready var heart_sprite = $Heart
@onready var heart_anim = $Heart_blow

func _on_heart_blow():
	heart_anim.play("blow")
	heart_anim.visible = true
	heart_sprite.visible = false
	await heart_anim.animation_finished
	self.queue_free()
