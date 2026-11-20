class_name PowerUp extends Area2D

# Player statistic this power up affects
enum PowerUpType {
	HEALTH
}
# TODO: Add other power ups such as ARMOR, DAMAGE, and SPEED


@export var power_up_type: PowerUpType
@export var power_up_amount: int = 0

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body : CharacterBody2D):
	if body.is_in_group("Player"):
		# find the player
		if body != null:
			if power_up_type == PowerUpType.HEALTH:
				body.GetHurt(power_up_amount)
				
			queue_free()
