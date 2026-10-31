class_name PlayerInteractionsHost extends Node2D

@onready var player: Player = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.DirectionChanged.connect(UpdateDirection)
	pass # Replace with function body.


func UpdateDirection(new_direction : Vector2) -> void:
	if new_direction == Vector2.DOWN:
		#print("down")
		position = Vector2(0, 10)
		#rotation_degrees = 0
	elif new_direction == Vector2.UP:
		#print("up")
		position = Vector2(0, -100)
	#	rotation_degrees = -10
	elif new_direction == Vector2.LEFT:
		#print("left")
		position = Vector2(-30,-40)
	elif new_direction == Vector2.RIGHT:
		#print("right")
		position = Vector2(30,-40)
	else: 
		position = Vector2(0, 10)
#	
	#match new_direction:
	#	Vector2.DOWN:
	#		print("down")
	#		rotation_degrees = 0
	#	Vector2.UP:
	#		print("up")
	#		rotation_degrees = 90
	#	#Vector2.LEFT:
	#	#	rotation_degrees = 90
	#	#Vector2.RIGHT:
	#	#	rotation_degrees = 270
	#	_:
	#		rotation_degrees = 0
	pass
