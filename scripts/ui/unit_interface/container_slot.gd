extends GridContainer

class_name ContainerSlot

var ItemSlot = load("res://scenes/ui/unit_inventory/unit_slot.tscn")
var slots

func display_item_slot(cols: int, rows: int):
	var item_slot
	var unit_size = UnitInventory.units_inventory.size() - 1
	columns = cols
	slots = cols * rows
	
	if unit_size < slots:
		for i in range(slots):
			UnitInventory.units_inventory.append({})
	
	for index in range(slots):
		item_slot = ItemSlot.instantiate()
		add_child(item_slot)
		item_slot.display_item(UnitInventory.units_inventory[index])
	UnitInventory.items_changed.connect(_on_Inventory_items_changed)

func _on_Inventory_items_changed(indexes):
	var item_slot
	
	for index in indexes:
		if index < slots:
			item_slot = get_child(index)
			item_slot.display_item(UnitInventory.units_inventory[index])
