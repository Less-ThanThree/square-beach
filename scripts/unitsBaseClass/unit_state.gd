extends Unit

class_name UnitState

var current_state

func _process(delta):
	match current_state:
		"idle":
			animation_unit_play(animation_sprite ,current_state)
		"move":
			animation_unit_play(animation_sprite ,current_state)
			move_to(delta)
		"attack":
			animation_unit_play(animation_sprite ,current_state)
