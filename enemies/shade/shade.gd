class_name Shade extends CharacterBody2D

var health : int
var direction : Vector2 = Vector2.ZERO
var speed = 75
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D


func _ready() -> void:
	health = randi_range(3,7) # set random amount of health
	$HitBox.Damaged.connect(TakeDamage)
	#animation_player.play("walk_down")
	animation_player.play("idle_down")
	
func TakeDamage(_damage : int) -> void:
	health -= 1
	print("health: ", health)
	
	# make the particles explode
	
	cpu_particles_2d.amount = 30 #50
	cpu_particles_2d.scale_amount_min = 0.2
	cpu_particles_2d.scale_amount_max = 1.0
	#cpu_particles_2d.color = Color.FIREBRICK
	cpu_particles_2d.gravity = Vector2.ZERO
	cpu_particles_2d.one_shot = true
	cpu_particles_2d.explosiveness = 1.0
	cpu_particles_2d.direction = Vector2.RIGHT
	cpu_particles_2d.spread = 180.0 #360.0
	cpu_particles_2d.initial_velocity_min = 100.0;
	cpu_particles_2d.initial_velocity_max = 200.0;
	cpu_particles_2d.radial_accel_min = 100.0;
	cpu_particles_2d.radial_accel_max = 150.0;
	cpu_particles_2d.tangential_accel_min = 200.0;
	cpu_particles_2d.tangential_accel_max = 250.0;
	cpu_particles_2d.damping_min = 0.0;
	cpu_particles_2d.damping_max = 0.0;
	cpu_particles_2d.lifetime = 1.0
	cpu_particles_2d.emitting = true
	
	if health <= 0:
		queue_free() # he died

func update_direction():
	velocity.y = speed * 1
	# set player limits TODO: make this get the values instead of hardcoded
	var margin = 5.0
	global_position.x = clampf(
		global_position.x,
		-600 + margin,
		3250 - margin
	)
	global_position.y = clampf(
		global_position.y,
		-350 + margin,
		2000 - margin
	)

func _physics_process(_delta):
	update_direction()
	move_and_slide()
	
