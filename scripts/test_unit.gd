extends StaticBody3D  # Уточняем тип узла

var health = 100
signal unit_died

# Инициализация HealthBar
@onready var health_bar = $HealthBar

func _ready():
	health_bar.value = health  # Инициализируем значение здоровья

func take_damage(amount: int) -> void:
	health -= amount
	health_bar.value = health  # Обновляем индикатор здоровья
	print("Health after damage: ", health)
	if health <= 0:
		print("Test Unit died!")
		emit_signal("unit_died")
		queue_free()  # Удаляем юнита при достижении нулевого здоровья
