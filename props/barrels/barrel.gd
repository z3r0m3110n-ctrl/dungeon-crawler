class_name Barrel extends Node2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: Sprite2D = $Barrel
var barrelbreak = preload("res://props/barrels/barrelbreak.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)
	
func TakeDamage(_damage : int) -> void:
	sprite.texture = load("res://props/sprites/barrel-broken.png")
	audio.stream = barrelbreak
	audio.play() 
	await audio.finished
	queue_free()
