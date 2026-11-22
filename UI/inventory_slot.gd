class_name SlotUI extends Panel

@export var index : int = 0


@onready var icon: TextureRect = $Icon
@onready var quantity_label: Label = $QuantityLabel


func refresh():
	var stack : ItemStack = Inventory._get_stack(index)
	
	# there is no item to display
	if stack == null:
		icon.texture = null
		
	else:
		icon.texture = stack.item.icon
		
		if stack.quantity > 1: #don't display number if only one of them
			quantity_label.text = str(stack.quantity)
		
		tooltip_text = "%s" % [stack.item.display_name] 
