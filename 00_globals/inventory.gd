extends Node

signal inventory_changed

const INV_SIZE := 24
var slots: Array = [] 

func _ready() -> void:
	slots.resize(INV_SIZE)
	
func add_item(item: ItemData, quantity : int = 1):
	# for now, just add the item to a new slot
		for i in INV_SIZE:
			if quantity == 0: 
				break
			if slots[i] == null:
				slots[i] = ItemStack.new(item, quantity)
				quantity -= 1
				inventory_changed.emit()
				
func _get_stack(i: int) -> ItemStack:
	return slots[i]

func get_player() -> Node:
	return get_tree().get_first_node_in_group("player")
