class_name ShortSword extends Area2D

@export var item: ItemData = load("res://props/weapons/swords/short_sword.tres")
@export var qty := 1
@export var pickup_range := 64.0

@onready var label: Label = $Label


func _ready():
	#body_entered.connect(_on_body_entered)
	
	# name label above item
	label.hide()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered():
	label.show()

func _on_mouse_exited():
	label.hide()
	
#func _on_body_entered(body : CharacterBody2D):
	#print("short sword entered")
	#if body.is_in_group("Player"):
		#
		## find the player
		#if body != null:
			#Inventory.add_item(item, qty)      
			#queue_free()   
			
func _input_event(viewport: Viewport, event: InputEvent, _shape: int) -> void:
	if event is InputEventMouseButton and event.pressed \
			and event.button_index == MOUSE_BUTTON_LEFT:
		var player := Inventory.get_player()
		if player and global_position.distance_to(player.global_position) > pickup_range:
			return                              
		Inventory.add_item(item, qty)       
		queue_free()                
		viewport.set_input_as_handled()             
