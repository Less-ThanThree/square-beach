extends Control

@onready var label_player = $Sprite2D/Tron_Player
@onready var label_enemie = $Sprite2D2/Tron_Enemie

func _ready():
	label_player.text = "Tron: " + str(Global.tron_player_hp)
	label_enemie.text = "Tron: " + str(Global.tron_enemie_hp)

func _on_main_update_label_tron():
	label_player.text = "Tron: " + str(Global.tron_player_hp)
	label_enemie.text = "Tron: " + str(Global.tron_enemie_hp)
