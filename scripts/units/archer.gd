extends Unit

@onready var animation_player = %AnimatedSprite

func _ready():
	animation_player.play("idle")
