class_name HurtBox extends Area2D

@export var damage : int = 1
var max_damage : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(AreaEntered)


func AreaEntered(a : Area2D) -> void:
	if a is HitBox:
		#print('hurt box damage: ', damage)
		a.TakeDamage(damage)

func SetDamage(d : int) -> void:
	damage = d
	clampi(damage, 0, max_damage)

func SetBonusDamage(d : int) -> void:
	damage += d
	clampi(damage, 0, max_damage)
