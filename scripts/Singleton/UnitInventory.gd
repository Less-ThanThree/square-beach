extends Node

signal items_changed(indexes)

var cols: int = 8
var rows: int = 2
var slots: int = cols * rows
var units_inventory: Array = []
var pick_unit: Object

#func _ready():
	#for i in range(slots):
		#units_inventory.append({)
#
	#units_inventory[0] = {
		#"icon": "1.png",
		#"count": 2,
	#}
	#
	#units_inventory[1] = {
		#"icon": "2.png",
		#"count": 2,
	#}

func set_item(index, item):
	var previos_item = units_inventory[index]
	units_inventory[index] = item
	items_changed.emit([index])
	return previos_item

func remove_item(index):
	var previos_item = units_inventory[index].duplicate()
	units_inventory[index].clear()
	items_changed.emit([index])
	return previos_item

func set_unit_pick(unit):
	pick_unit = unit
