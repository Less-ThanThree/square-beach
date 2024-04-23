extends Node

@export var level_start_scene: PackedScene

func _on_button_start_game_pressed():
	get_tree().change_scene_to_packed(level_start_scene)
