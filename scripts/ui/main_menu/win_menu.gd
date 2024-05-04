extends Node

@onready var restart_button = $ButtonRestart
@onready var exit_button = $ButtonExit

func _on_button_exit_pressed():
	get_tree().quit()
