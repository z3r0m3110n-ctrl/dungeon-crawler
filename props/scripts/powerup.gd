class_name PowerUp extends Area2D


# Player statistic this power up affects
enum PowerUpType {
	HEALTH,
	DAMAGE
}
# TODO: Add other power ups such as ARMOR and SPEED?

var start_y: float
var original_scale

@export var power_up_type: PowerUpType
@export var power_up_amount: int = 0
@onready var label: Label = $Label
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var power_sound = preload("res://props/audio/heart_collect.wav")

func _ready():
	body_entered.connect(_on_body_entered)
	start_y = position.y
	
	# name label above item
	label.hide()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	original_scale = $Sprite2D.scale

func _on_body_entered(body : CharacterBody2D):
	if body.is_in_group("Player"):
		# find the player
		if body != null:
			if power_up_type == PowerUpType.HEALTH:
				body.GetHurt(power_up_amount)
			elif power_up_type == PowerUpType.DAMAGE:
				body.SetWeaponBonusDamage(power_up_amount)
				
			# play the power up sound
			audio.stream = power_sound
			audio.play() 
			await audio.finished
			queue_free()

func _on_mouse_entered():
	label.show()

func _on_mouse_exited():
	label.hide()


func _process(_delta):
	#var float_speed = 2.0
	#var float_amount = 8.0
	#position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_amount
	
	# have the powerup shrink and grow
	var pulse_amount = 0.1
	var pulse_speed = 3.0
	var pulse = 1.0 + sin(Time.get_ticks_msec() / 1000.0 * pulse_speed) * pulse_amount
	$Sprite2D.scale = original_scale * pulse
	#$Shadow.scale = Vector2.ONE * pulse
	
