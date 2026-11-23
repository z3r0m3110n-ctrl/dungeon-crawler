extends Node

signal inventory_changed
enum Kind { INVENTORY, EQUIPMENT }
const INV_SIZE := 24
var slots: Array = []
var equip_layout: Array[ItemData.EquipSlot] = []
var equipment: Array = []

func _ready() -> void:
	slots.resize(INV_SIZE)

func setup_equipment(layout: Array[ItemData.EquipSlot]) -> void:
	equip_layout = layout
	equipment.clear()
	equipment.resize(layout.size())
	
func add_item(item: ItemData, quantity : int = 1):
	# for now, just add the item to a new slot
	for i in INV_SIZE:
		if quantity == 0: 
			break
		if slots[i] == null:
			slots[i] = ItemStack.new(item, quantity)
			quantity -= 1
	inventory_changed.emit()

	#print("add_item: ", item.display_name if item else "NULL")
	#for i in INV_SIZE:
		#if slots[i]: print("  bag slot ", i, ": ", slots[i].item.display_name)			

func _get_stack(kind: Kind, i: int) -> ItemStack:
	var arr := slots if kind == Kind.INVENTORY else equipment
	if i < 0 or i >= arr.size():
		return null
	return arr[i]
	
func _set_stack(kind: Kind, i: int, s: ItemStack) -> void:
	if kind == Kind.INVENTORY:
		slots[i] = s
	else:
		equipment[i] = s

func get_player() -> Node:
	return get_tree().get_first_node_in_group("player")

func activate(index: int) -> void:
	var s: ItemStack = slots[index]
	if s == null:
		return
	match s.item.type:
		ItemData.ItemType.WEAPON, ItemData.ItemType.ARMOR:
			var target := _find_equip_slot(s.item)
			if target >= 0:
				move(Kind.INVENTORY, index, Kind.EQUIPMENT, target)

func _find_equip_slot(item: ItemData) -> int:
	var first_match := -1
	for i in equip_layout.size():
		if equip_layout[i] == item.equip_slot:
			if equipment[i] == null:
				return i                       # prefer an empty slot
			if first_match < 0:
				first_match = i
	return first_match 
	
#func move(from_kind: Kind, from_i: int, to_kind: Kind, to_i: int) -> void:
	#if from_kind == to_kind and from_i == to_i:
		#return
	#var a := _get_stack(from_kind, from_i)
	#var b := _get_stack(to_kind, to_i)
	#if a == null:
		#return
	## validate both directions, since an occupied target means a swap
	#if not _accepts(to_kind, to_i, a) or not _accepts(from_kind, from_i, b):
		#return

func _accepts(kind: Kind, i: int, s: ItemStack) -> bool:
	if s == null or kind == Kind.INVENTORY:
		return true
	if i < 0 or i >= equip_layout.size():
		return false
	return s.item.equip_slot == equip_layout[i]	
	
func move(from_kind: Kind, from_i: int, to_kind: Kind, to_i: int) -> void:
	var a := _get_stack(from_kind, from_i)
	var b := _get_stack(to_kind, to_i)
	
	#if a == null:
		#return
	#if not _accepts(to_kind, to_i, a) or not _accepts(from_kind, from_i, b):
		#return

	if b and from_kind == Kind.INVENTORY and to_kind == Kind.INVENTORY \
			and a.item == b.item and a.item.max_stack > 1:
		var moved := mini(a.qty, a.item.max_stack - b.qty)
		b.qty += moved
		a.qty -= moved
		if a.qty <= 0:
			slots[from_i] = null
	else:
		_set_stack(to_kind, to_i, a)
		_set_stack(from_kind, from_i, b)
	inventory_changed.emit()
