class_name Playground extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set the player starting position
	$Player.global_position = Vector2(500, 300)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
