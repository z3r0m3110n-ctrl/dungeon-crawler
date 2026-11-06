class_name Shade extends CharacterBody2D

var health : int
var direction : Vector2 = Vector2.ZERO
var speed = 75
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	health = randi_range(3,7) # set random amount of health
	$HitBox.Damaged.connect(TakeDamage)
	
func TakeDamage(_damage : int) -> void:
	health -= 1
	print("health: ", health)
	gpu_particles_2d.one_shot = true
	gpu_particles_2d.emitting = true
	if health <= 0:
		queue_free() # he died

#func _physics_process(_delta):
	#move_and_slide()
	
