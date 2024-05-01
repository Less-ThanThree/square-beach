extends StaticBody3D  # Уточняем тип узла

var health = 100

var mana = 100
var max_mana = 100
var mana_regeneration_rate = 1

signal unit_died

# Инициализация HealthBar
@onready var health_bar = $HealthBar

func _ready():
	health_bar.value = health  # Инициализируем значение здоровья
	
func _process(delta):
	if mana < max_mana:
		mana += mana_regeneration_rate * delta
		mana = min(mana, max_mana)
	update_mana_bar()

func take_damage(amount: int) -> void:
	health -= amount
	health_bar.value = health  # Обновляем индикатор здоровья
	print("Health after damage: ", health)
	if health <= 0:
		print("Test Unit died!")
		emit_signal("unit_died")
		queue_free()  # Удаляем юнита при достижении нулевого здоровья
		
func update_mana_bar():
	$ManaBar.value = mana
	$ManaBar.max_value = max_mana

func _on_add_mana_pressed():
	mana += 10
	mana = min(mana, max_mana)
	update_mana_bar()

func _on_use_mana_pressed():
	if mana >= 10:
		mana -= 10
		print("Спелл закастился")
		update_mana_bar()
	else:
		print("Недостаточно маны")

func _on_increase_max_mana_pressed():
	max_mana += 10
	update_mana_bar()

func _on_decrease_max_mana_pressed():
	max_mana = max(10, max_mana - 10)  # Не допускаем макс. ману меньше 10
	mana = min(mana, max_mana)
	update_mana_bar()

func _on_increase_mana_regen_pressed():
	mana_regeneration_rate += 1

func _on_decrease_mana_regen_pressed():
	mana_regeneration_rate = max(0, mana_regeneration_rate - 1)  # Регенерация не может быть меньше 0
