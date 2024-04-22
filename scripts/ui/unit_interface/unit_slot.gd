extends ColorRect

@onready var item_icon = $UnitIcon
@onready var item_quantity = $LabelQuantity

func display_item(item):
	if item:
		item_icon.texture = load("res://assets/ui/ui_icons_inventory/%s" % item.icon)
		item_quantity.text = str(item.count)
	else:
		item_icon.texture = null
		item_quantity.text = ""
