class_name ItemData extends Resource

enum ItemType {
	WEAPON,
	ARMOR,
	CONSUMABLE,
	GENERAL
}
# This is the general information for the item
@export var id : String # the item id
@export var display_name : String # the display name
@export var icon : Texture2D
@export var type : ItemType = ItemType.GENERAL

# How many  you have stacks of this item?
@export var max_stack : int = 1
