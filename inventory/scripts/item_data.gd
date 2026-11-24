class_name ItemData extends Resource

enum ItemType {
	WEAPON,
	ARMOR,
	HELMET,
	GAUNTLETS,
	GREAVES,
	BOOTS,
	PAULDRONS,
	OFFHAND,
	CONSUMABLE,
	GENERAL
}
enum EquipSlot {
	NONE,
	MAIN_HAND,
	TORSO,
	HEAD,
}


# This is the general information for the item
@export var id : String # the item id
@export var display_name : String # the display name
@export var icon : Texture2D
@export var type : ItemType = ItemType.GENERAL
@export var equip_slot: EquipSlot = EquipSlot.NONE

# How items in a stack?
@export var max_stack : int = 1

# WeaponStats
@export_group("Weapon")
@export var damage := 0
