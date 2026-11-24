class_name SlotUI extends Panel

@export var index : int = 0
@export var equip_slot: ItemData.EquipSlot = ItemData.EquipSlot.NONE
@export var kind: Inventory.Kind = Inventory.Kind.INVENTORY
@onready var icon: TextureRect = $Icon
@onready var quantity_label: Label = $QuantityLabel



func has_item() -> bool:
	return Inventory._get_stack(kind, index) != null


func refresh():
	#print("refresh ", kind, " ", index, " icon=", icon.texture if icon else "NO ICON NODE")
	var stack : ItemStack = Inventory._get_stack(kind,index)
	
	# there is no item to display
	#if stack == null:
	#	icon.texture = null
	icon.texture = null
	if stack:
		#print("refresh kind=", kind, " index=", index, " item=", stack.item.display_name,
				#" icon=", stack.item.icon, " icon_node_size=", icon.size,
				#" slot_size=", size, " slot_pos=", global_position)
		icon.texture = stack.item.icon
		
		if stack.quantity > 1: #don't display number if only one of them
			quantity_label.text = str(stack.quantity)
		
		tooltip_text = "%s" % [stack.item.display_name] 
			

func _get_drag_data(_at: Vector2) -> Variant:
	var s: ItemStack = Inventory._get_stack(kind, index)
	#print("DRAG START kind=", kind, " index=", index, " stack=", s)
	if s == null: return null
	var preview := TextureRect.new()
	preview.texture = s.item.icon
	preview.size = Vector2(32, 32)
	set_drag_preview(preview)
	return {"kind": kind, "index": index}

#func GetStats() -> void:
	#var s: ItemStack = Inventory._get_stack(kind, index)
	#icon.texture = s.item.icon if s else null
	#quantity_label.text = str(s.qty) if s and s.qty > 1 else ""
#
	#if s != null:
		#ItemStats.emit(s.item)
		#print("this is being emitted")
	#else:
		#print("slot ", index, " is empty")

func _can_drop_data(_at: Vector2, data: Variant) -> bool:
	if not (data is Dictionary and data.has("index")):
		return false
	var carried: ItemStack = Inventory._get_stack(data.kind, data.index)
	var occupant: ItemStack = Inventory._get_stack(kind, index)
	var ok: bool = Inventory._accepts(kind, index, carried) \
			and Inventory._accepts(data.kind, data.index, occupant)
	return ok

func _drop_data(_at: Vector2, data: Variant) -> void:
	Inventory.move(data.kind, data.index, kind, index)
