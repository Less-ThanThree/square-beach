extends Node3D

@onready var unit_inventory = $Ui/UnitInventory
@onready var player = $Player
@onready var line_1_spawn = $Lines/Line
@onready var line_2_spawn = $Lines/Line2
@onready var line_3_spawn = $Lines/Line3

var current_line: int
var current_unit
var current_unit_scene

func _ready():
	unit_inventory.connect("pick_unit", _on_pick)
	player.connect("on_line", _on_line)

func _on_pick(unit):
	spawn_unit(current_line, unit)
	print(unit.name)

func _on_line(line_number):
	current_line = line_number
	print("Player on line %d" % line_number)

func spawn_unit(line_number, unit):
	var rand_pos_x = randf_range(-49, -45)
	var rand_pos_z = randf_range(1.8, -1.8)
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
