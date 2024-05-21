extends Unit

class_name UnitState

var current_state

func _process(delta):
	match current_state:
		"idle":
			animation_unit_play(animation_sprite ,current_state)
		"move":
			animation_unit_play(animation_sprite ,current_state)
			if is_enemy:
				move_to_reverse(delta)
			else:
				move_to(delta)
		"attack":
			animation_unit_play(animation_sprite ,current_state)
		"die":
			animation_unit_play(animation_sprite, current_state)
		"hit":
			animation_unit_play(animation_sprite, current_state)
