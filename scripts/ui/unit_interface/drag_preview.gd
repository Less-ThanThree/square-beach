extends Control

@onready var unit_icon = $Item/UnitIcon
@onready var unit_quantity = $Item/LabelQuantity

var dragged_item = {} : set = set_dragged_item

func _process(delta):
	if dragged_item:
		position = get_global_mouse_position()

func set_dragged_item(item):
	dragged_item = item
	if dragged_item:
		unit_icon.texture = load("res://assets/ui/ui_icons_inventory/%s" % dragged_item.icon)
		#unit_quantity.text = str(dragged_item.count)
	else:
		unit_icon.texture = null
		unit_quantity = ""
