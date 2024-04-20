extends Button

func _ready():
	# Здесь используем Callable для связи события pressed с методом _on_Button_pressed
	connect("pressed", Callable(self, "_on_Button_pressed"))

func _on_Button_pressed():
	var unit = $"../"
	if unit:
		unit.take_damage(40)  # Вызываем метод take_damage непосредственно
