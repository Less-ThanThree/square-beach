extends Node3D

signal update_label_tron(type)
signal start_phase_cast
signal start_phase_fight

@onready var unit_inventory = $Ui/UnitInventory
@onready var player = $Node/Player
@onready var line_1_spawn = $Node/Lines/Line
@onready var line_2_spawn = $Node/Lines/Line2
@onready var line_3_spawn = $Node/Lines/Line3
@onready var tron_player = $Node/Tron_player
@onready var tron_enemie = $Node/Tron_enemies
@onready var cast_scene = $Ui/Cast
@onready var fight = $Node

# ONLY GAMEJAME
@onready var howler = load("res://scenes/enemies/void/howler.tscn")
@onready var sprout = load("res://scenes/enemies/vita/sprout.tscn")
@onready var oiltender = load("res://scenes/enemies/void/tenderil_sight.tscn")
@onready var bloomshot = load("res://scenes/enemies/vita/bloom_shot.tscn")
@onready var darkspout = load("res://scenes/enemies/void/dark_spout.tscn")
@onready var chompsavor = load("res://scenes/enemies/void/chomp_savor.tscn")
# ONLY GAMEJAME

@export var die_menu: PackedScene
@export var win_menu: PackedScene

var current_line: int
var current_unit
var current_unit_scene
var current_wave = 1

func _ready():
	unit_inventory.connect("pick_unit", _on_pick)
	player.connect("on_line", _on_line)
	start_phase_cast.emit()
	get_tree().paused = true

func _on_pick(unit):
	spawn_unit(current_line, unit)

func _on_line(line_number):
	current_line = line_number
	print("Player on line %d" % line_number)

func spawn_unit(line_number, unit):
	var rand_pos_x = randf_range(-47, -45)
	var rand_pos_z = randf_range(1.4, -1.4)
	if unit.has("scene"):
		if ResourceLoader.exists(unit.scene):
			current_unit_scene = ResourceLoader.load(unit.scene).instantiate()
			if current_unit_scene:
				current_unit_scene.position = Vector3(rand_pos_x, 0.625, rand_pos_z)
				match line_number:
					1:
						line_1_spawn.add_child(current_unit_scene)
					2:
						line_2_spawn.add_child(current_unit_scene)
					3:
						line_3_spawn.add_child(current_unit_scene)
			current_unit_scene = null

func _on_area_3d_body_entered(body):
	if body.is_in_group("goblin"):
		Global.tron_player_hp -= 1
		update_label_tron.emit("allience")
		body.queue_free()
		if Global.tron_player_hp <= 0:
			await tron_player.on_tron_destroy()
			get_tree().change_scene_to_packed(die_menu)
	
	if body.is_in_group("allience"):
		Global.tron_enemie_hp -= 1
		update_label_tron.emit("goblin")
		body.queue_free()
		if Global.tron_enemie_hp <= 0:
			await tron_enemie.on_tron_destroy()
			get_tree().change_scene_to_packed(win_menu)

func _on_cast_end_phase_cast():
	get_tree().paused = false
	cast_scene.visible = false
	start_phase_fight.emit()
	# ONLY GAMEJAME
	if current_wave > 4:
		current_wave = 1
	match current_wave:
		1:
			spawn_wave_1()
		2:
			spawn_wave_2()
		3:
			spawn_wave_3()
		4:
			spawn_wave_4()
	current_wave += 1
	# ONLY GAMEJAME

func _on_base_info_end_phase_fight():
	get_tree().paused = true
	cast_scene.visible = true
	start_phase_cast.emit()

# ONLY GAMEJAME
func spawn_wave_1():
	var howler_unit_1 = howler.instantiate()
	howler_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_1.unit_is_enemy = true
	var howler_unit_2 = howler.instantiate()
	howler_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_2.unit_is_enemy = true
	var dark_spout_unit_1 = darkspout.instantiate()
	dark_spout_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	dark_spout_unit_1.unit_is_enemy = true
	var sprout_unit_1 = sprout.instantiate()
	sprout_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	sprout_unit_1.unit_is_enemy = true
	var sprout_unit_2 = sprout.instantiate()
	sprout_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	sprout_unit_2.unit_is_enemy = true
	line_1_spawn.add_child(howler_unit_1)
	line_1_spawn.add_child(howler_unit_2)
	line_1_spawn.add_child(dark_spout_unit_1)
	line_3_spawn.add_child(sprout_unit_1)
	line_3_spawn.add_child(sprout_unit_2)

func spawn_wave_2():
	var howler_unit_1 =  howler.instantiate()
	howler_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_1.unit_is_enemy = true
	var howler_unit_2 =  howler.instantiate()
	howler_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_2.unit_is_enemy = true
	var oiltender_unit_1 = oiltender.instantiate()
	oiltender_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	oiltender_unit_1.unit_is_enemy = true
	var oiltender_unit_2 = oiltender.instantiate()
	oiltender_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	oiltender_unit_2.unit_is_enemy = true
	var bloomshot_unit_1 = bloomshot.instantiate()
	bloomshot_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	bloomshot_unit_1.unit_is_enemy = true
	var bloomshot_unit_2 = bloomshot.instantiate()
	bloomshot_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	bloomshot_unit_2.unit_is_enemy = true
	line_1_spawn.add_child(howler_unit_1)
	line_1_spawn.add_child(howler_unit_2)
	line_1_spawn.add_child(oiltender_unit_1)
	line_1_spawn.add_child(oiltender_unit_2)
	line_2_spawn.add_child(bloomshot_unit_1)
	line_3_spawn.add_child(bloomshot_unit_2)

func spawn_wave_3():
	var darkspout_unit_1 = darkspout.instantiate()
	darkspout_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	darkspout_unit_1.unit_is_enemy = true
	var darkspout_unit_2 = darkspout.instantiate()
	darkspout_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	darkspout_unit_2.unit_is_enemy = true
	var howler_unit_1 = howler.instantiate()
	howler_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_1.unit_is_enemy = true
	var oiltender_unit_1 = oiltender.instantiate()
	oiltender_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	oiltender_unit_1.unit_is_enemy = true
	var chompsavor_unit_1 = chompsavor.instantiate()
	chompsavor_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	chompsavor_unit_1.unit_is_enemy = true
	line_1_spawn.add_child(darkspout_unit_1)
	line_1_spawn.add_child(darkspout_unit_2)
	line_2_spawn.add_child(howler_unit_1)
	line_3_spawn.add_child(oiltender_unit_1)
	line_3_spawn.add_child(chompsavor_unit_1)

func spawn_wave_4():
	var darkspout_unit_1 = darkspout.instantiate()
	darkspout_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	darkspout_unit_1.unit_is_enemy = true
	var sprout_unit_1 = sprout.instantiate()
	sprout_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	sprout_unit_1.unit_is_enemy = true
	var sprout_unit_2 = sprout.instantiate()
	sprout_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	sprout_unit_2.unit_is_enemy = true
	var howler_unit_1 = howler.instantiate()
	howler_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_1.unit_is_enemy = true
	var howler_unit_2 = howler.instantiate()
	howler_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	howler_unit_2.unit_is_enemy = true
	var oiltender_unit_1 = oiltender.instantiate()
	oiltender_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	oiltender_unit_1.unit_is_enemy = true
	var oiltender_unit_2 = oiltender.instantiate()
	oiltender_unit_2.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	oiltender_unit_2.unit_is_enemy = true
	var blomshoot_unit_1 = bloomshot.instantiate()
	blomshoot_unit_1.position = Vector3(randf_range(47, 45), 0.625, randf_range(1.4, -1.4))
	blomshoot_unit_1.unit_is_enemy = true
	line_1_spawn.add_child(darkspout_unit_1)
	line_2_spawn.add_child(sprout_unit_1)
	line_2_spawn.add_child(sprout_unit_2)
	line_2_spawn.add_child(howler_unit_1)
	line_2_spawn.add_child(howler_unit_2)
	line_2_spawn.add_child(oiltender_unit_1)
	line_2_spawn.add_child(oiltender_unit_2)
	line_3_spawn.add_child(blomshoot_unit_1)
	# ONLY GAMEJAME
