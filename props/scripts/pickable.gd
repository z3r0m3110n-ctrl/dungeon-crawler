@tool
class_name PickableItem
extends Area2D

@export var item: ItemData:
	set(value):
		item = value
		if is_node_ready():
			_apply_item()
@export var qty := 1
@export var pickup_range := 64.0
@export_multiline var description := ""
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

func _ready() -> void:
	_apply_item()
	if Engine.is_editor_hint():
		return                                  
	label.hide()
	mouse_entered.connect(label.show)
	mouse_exited.connect(label.hide)


func _apply_item() -> void:
	if item == null:
		if not Engine.is_editor_hint():
			push_warning("PickableItem '%s' has no item assigned" % name)
		return
	sprite.texture = item.icon
	label.text = item.display_name if qty <= 1 else "%s x%d" % [item.display_name, qty]

func _input_event(viewport: Viewport, event: InputEvent, _shape: int) -> void:
	#print("clicked: ", name, "item: ", item)
	if item == null: 
		return
	if event is InputEventMouseButton and event.pressed \
			and event.button_index == MOUSE_BUTTON_LEFT:
		viewport.set_input_as_handled()
		var player := Inventory.get_player()
		if player and global_position.distance_to(player.global_position) > pickup_range:
			return                               # TODO: a "too far" message?
		Inventory.add_item(item, qty)      # TODO: Check if full
		queue_free()                
		viewport.set_input_as_handled()   
		
