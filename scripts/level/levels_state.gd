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
@onready var chomp_1 = $Node/Lines/Line/Enemies/ChompSavor
@onready var chomp_2 = $Node/Lines/Line/Enemies/DarkSpout
@onready var cast_scene = $Ui/Cast
@onready var fight = $Node
#@onready var chomp_3 = $Lines/Line/Enemies/Howler
#@onready var chomp_4 = $Lines/Line/Enemies/TenderilSight

@export var die_menu: PackedScene
@export var win_menu: PackedScene

var current_line: int
var current_unit
var current_unit_scene

func _ready():
	unit_inventory.connect("pick_unit", _on_pick)
	player.connect("on_line", _on_line)
	
	chomp_1.unit_is_enemy = true
	chomp_2.unit_is_enemy = true
	
	start_phase_cast.emit()
	get_tree().paused = true
	#self.PROCESS_MODE_PAUSABLE

	
	#chomp_3.unit_is_enemy = true
	#chomp_4.unit_is_enemy = true

func _on_pick(unit):
	spawn_unit(current_line, unit)
	#print(unit.name)

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

func _on_base_info_end_phase_fight():
	get_tree().paused = true
	cast_scene.visible = true
	start_phase_cast.emit()
