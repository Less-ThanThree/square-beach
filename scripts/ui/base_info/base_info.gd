extends Control

signal end_phase_fight

@onready var tron_player = $TronPlayer
@onready var tron_enemie = $TronEnemie
@onready var phase_timer = $TimerOnStartPhase
@onready var timer_label = $PhaseTimer

var hearts_player: Array = []
var hearts_enemies: Array = []

func _ready():
	for i in Global.tron_player_hp:
		hearts_player.push_back("TronPlayer/HeartUiTron" + str(i + 1))
	
	for i in Global.tron_enemie_hp:
		hearts_enemies.push_back("TronEnemie/HeartUiTron" + str(i + 1))
	
	phase_timer.wait_time = Global.time_phase_fight

func _process(delta):
	update_timer_phase(phase_timer.time_left)

func _on_main_update_label_tron(type):
	var current_heart
	if type == "goblin" && hearts_enemies.size() > 0:
		current_heart = get_node(hearts_enemies.back())
		hearts_enemies.pop_back()
		current_heart.emit_signal("heart_blow")
	if type == "allience" && hearts_player.size() > 0:
		current_heart = get_node(hearts_player.back())
		hearts_player.pop_back()
		current_heart.emit_signal("heart_blow")

func _on_timer_on_start_phase_timeout():
	end_phase_fight.emit()

func update_timer_phase(time: float):
	timer_label.text = "Time fight: " + str(time).pad_decimals(1)

func _on_main_start_phase_fight():
	phase_timer.start()
