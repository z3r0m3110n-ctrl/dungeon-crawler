class_name ItemStack extends RefCounted

@export var item : ItemData
@export var quantity : int = 1

func _init(i: ItemData, q: int = 1):
	item = i
	quantity = q
