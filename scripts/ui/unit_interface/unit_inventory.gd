extends Control

signal pick_unit(unit)

@onready var container_unit = $Container
@onready var drag_preview = $DragPreview
@onready var control_button = $Container/ControlUnit

var tween

func _ready():
	tween = Tween
	for unit_slot in get_tree().get_nodes_in_group("unit_slot"):
		var index = unit_slot.get_index()
		unit_slot.connect("gui_input", _on_UnitSlot_gui_input.bind(index))

func _on_control_unit_toggled(toggled_on):
	# Не даем закрыть инвентарь пока взят юнит
	if drag_preview.dragged_item && toggled_on: return
	
	if toggled_on:
		tween = create_tween().set_trans(Tween.TRANS_EXPO)
		tween.tween_property(container_unit, 'position', Vector2(0, container_unit.position.y + 100), 1)
		control_button.disabled = true
		await tween.finished
		control_button.disabled = false
	else:
		tween = create_tween().set_trans(Tween.TRANS_QUINT)
		tween.tween_property(container_unit, 'position', Vector2(0, container_unit.position.y - 100), 1)
		control_button.disabled = true
		await tween.finished
		control_button.disabled = false

func _on_UnitSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			drag_item(index)
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			set_current_unit(index)

func drag_item(index):
	var unit_item = UnitInventory.units_inventory[index] 
	var dragged_item = drag_preview.dragged_item
	
	# Взять юнита
	if unit_item && !dragged_item:
		drag_preview.dragged_item = UnitInventory.remove_item(index)
	
	# Бросить юнита
	if !unit_item && dragged_item:
		drag_preview.dragged_item = UnitInventory.set_item(index, dragged_item)
	
	# Свапнуть юнита
	if unit_item && dragged_item:
		drag_preview.dragged_item = UnitInventory.set_item(index, dragged_item)

func set_current_unit(index):
	if UnitInventory.units_inventory[index].has("count"):
		UnitInventory.units_inventory[index].count -= 1
		pick_unit.emit(UnitInventory.units_inventory[index])
		if UnitInventory.units_inventory[index].count <= 0:
			UnitInventory.remove_item(index)
