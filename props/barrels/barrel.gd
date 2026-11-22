class_name Barrel extends Node2D

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: Sprite2D = $Barrel
@onready var static_body: StaticBody2D = $StaticBody2D
@onready var label: Label = $Label # name label

var barrelbreak = preload("res://props/barrels/barrelbreak.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)
	
	# name label above barrel
	label.hide()
	static_body.mouse_entered.connect(_on_mouse_entered)
	static_body.mouse_exited.connect(_on_mouse_exited)

func TakeDamage(_damage : int) -> void:
	sprite.texture = load("res://props/sprites/barrel-broken.png")
	audio.stream = barrelbreak
	audio.play() 
	await audio.finished
	
	# Randomly spawn a power up
	if randf() <= 0.75:
		var powerup_scene = [
			"res://props/HealthPotion/HealthPotion.tscn",
			"res://props/dagger/dagger.tscn"
		]
		
		var powerup = load(powerup_scene[randi_range(0, powerup_scene.size() - 1)]).instantiate()
		
		# Add the power up to the level
		get_parent().add_child(powerup)
		powerup.global_position = global_position
	
	# Destroy the barrel
	queue_free()

func _on_mouse_entered():
	label.show()

func _on_mouse_exited():
	label.hide()
	
	
