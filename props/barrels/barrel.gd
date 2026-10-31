class_name Barrel extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$HitBox.Damaged.connect(TakeDamage)
	
func TakeDamage(_damage : int) -> void:
	queue_free()
	pass
