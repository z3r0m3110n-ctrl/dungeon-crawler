class_name InventoryUI extends CanvasLayer

@onready var grid: GridContainer = $InventoryPanel/MainLayout/GridContainer
@onready var equipment_panel: Control = $InventoryPanel/MainLayout/EquipmentPanel
@onready var hud: CanvasLayer = $"../../HUD"

#const SHORT_SWORD := preload("res://props/weapons/swords/short_sword.tres") # testing

var ui_slots: Array[SlotUI] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS   
	# Get slots
	var i := 0
	for child in grid.get_children():
		if child is SlotUI:
			child.kind = Inventory.Kind.INVENTORY
			child.index = i
			ui_slots.append(child)
			i += 1
	# Equipment slots: each slot's "Equip Slot" Inspector setting defines the layout
	var layout: Array[ItemData.EquipSlot] = []
	i = 0
	for child in equipment_panel.get_children():
		if child is SlotUI:
			child.kind = Inventory.Kind.EQUIPMENT
			child.index = i
			layout.append(child.equip_slot)
			ui_slots.append(child)
			i += 1

	Inventory.setup_equipment(layout)        
	Inventory.inventory_changed.connect(_refresh)
	_refresh()
	hide()
	
	
func _refresh() -> void:
	for s in ui_slots: 
		#print("slot index: ", s.index)
		s.refresh()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		visible = not visible
		
		# Hide the health bar if the inventory is opened
		if visible:
			hud.hide()
		else:
			hud.show()
