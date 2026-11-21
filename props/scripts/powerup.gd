class_name PowerUp extends Area2D

# Player statistic this power up affects
enum PowerUpType {
	HEALTH,
	DAMAGE
}
# TODO: Add other power ups such as ARMOR and SPEED?


@export var power_up_type: PowerUpType
@export var power_up_amount: int = 0
@onready var label: Label = $Label

func _ready():
	body_entered.connect(_on_body_entered)
	
	# name label above item
	label.hide()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_body_entered(body : CharacterBody2D):
	if body.is_in_group("Player"):
		# find the player
		if body != null:
			if power_up_type == PowerUpType.HEALTH:
				body.GetHurt(power_up_amount)
			elif power_up_type == PowerUpType.DAMAGE:
				body.SetWeaponBonusDamage(power_up_amount)
			queue_free()

func _on_mouse_entered():
	label.show()

func _on_mouse_exited():
	label.hide()
