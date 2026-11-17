class_name HealthPotion extends Area2D

var regenerate : int = -25 # amount of damage
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		if body.is_in_group("Player"):
			#print("entered potion: ", body)
			# find the player
			var player : Node2D = get_tree().get_first_node_in_group("Player")
			if player != null:
				player.GetHurt(regenerate)
				
			queue_free()
