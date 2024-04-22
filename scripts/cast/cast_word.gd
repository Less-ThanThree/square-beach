extends Node

signal timer_on_type_timeout(word)
signal timer_on_cooldown_timeout(word)

var tween
@onready var paricles = $CPUParticles2D
@onready var timer_on_type = $TimerOnType
@onready var timer_on_cooldown = $TimerOnCooldown

func _ready():
	self["theme_override_colors/default_color"] = Color(0, 0, 0, 0)
	tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, 'theme_override_colors/default_color', Color(0, 0, 0, 1), 1)

func set_timer(time: float):
	timer_on_type.wait_time = time
	timer_on_type.start()

func start_cooldown(time: float):
	timer_on_cooldown.wait_time = time
	timer_on_cooldown.start()

func _on_timer_on_type_timeout():
	timer_on_type_timeout.emit(self)

func _on_timer_on_cooldown_timeout():
	timer_on_cooldown_timeout.emit(self)
