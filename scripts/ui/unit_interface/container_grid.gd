extends ContainerSlot

func _ready():
	display_item_slot(UnitInventory.cols, UnitInventory.rows)

func _on_cast_end_phase_cast():
	print("update")
	update_slots()

func _on_unit_inventory_pick_unit(unit):
	update_slots()
