class_name HitBox extends Area2D

signal Damaged(damage : int)

func TakeDamage(damage : int) -> void:
	print("Take damage: ", damage) # amount of damage
	Damaged.emit(damage)
	
