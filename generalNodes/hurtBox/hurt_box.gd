class_name HurtBox extends Area2D
# Area controls the damage that the player does

const DEFAULT_DAMAGE : int = 1
@export var damage : int = 0

#var max_damage : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = DEFAULT_DAMAGE # this is the default weapon damage
	area_entered.connect(AreaEntered)
	Inventory.weapon_changed.connect(NewWeapon)


func AreaEntered(a : Area2D) -> void:
	if a is HitBox:
		print("Weapon damage: ", damage)
		a.TakeDamage(damage)

func SetDamage(d : int) -> void:
	damage = d
	#clampi(damage, 0, max_damage)

func SetBonusDamage(d : int) -> void:
	damage += d
	#clampi(damage, 0, max_damage)

func NewWeapon():
	print("New weapon detected")
	var weapon = Inventory.get_weapon()
	if weapon:
		SetDamage(weapon.damage)
	else:
		SetDamage(DEFAULT_DAMAGE)
