extends Node

@onready var restart_button = $ButtonRestart
@onready var exit_button = $ButtonExit

@export var scene_start_level: PackedScene

func _on_button_restart_pressed():
	get_tree().change_scene_to_packed(scene_start_level)

func _on_button_exit_pressed():
	get_tree().quit()
