extends Unit

@onready var animation_player = %AnimatedSprite
var current_state = "idle"

func _ready():
	animation_player.play("idle")

func _process(delta):
	match current_state:
		"idle":
			animation_player.play("idle")
		"move":
			animation_player.play("move")
			move_to()

func _on_tree_entered():
	current_state = "move"
