extends WorldEnvironment

@export var state = 0  # Время суток: 0 - ясное небо, 1 - пасмурное небо, 2 - сумерки
var midnight = preload("res://scenes/background/Midnight.tres")  # Проверьте этот путь
var midday = preload("res://scenes/background/Midday.tres")      # Проверьте этот путь
var midday_cloudy = preload("res://scenes/background/Midday_cloudy.tres")  # Проверьте этот путь

func _ready():
	update_environment()

func update_environment():
	match state:
		0:
			environment.sky = midday
		1:
			environment.sky = midday_cloudy
		2:
			environment.sky = midnight
