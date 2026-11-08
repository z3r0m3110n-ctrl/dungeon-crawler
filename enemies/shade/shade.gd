class_name Shade extends CharacterBody2D

var health : int = 5
var in_danger : bool = false

var direction : Vector2 = Vector2.ZERO
var speed_walk : int = 75
var speed_idle : int = 0
var speed_danger : int = 200
var speed : int = 0
var thug_wannabe : int = 10 # time in the same direction 
var random_direction : int = 1
var animation_state : String = "idle"

var hiss_sound = preload("res://enemies/audio/hiss.wav")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var shade_sprite: Sprite2D = $Shade
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	health = randi_range(3,7) # set random amount of health
	$HitBox.Damaged.connect(TakeDamage)
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
	
	thug_wannabe -= 1
	#print("thug_wannabe:", thug_wannabe)
	if thug_wannabe <= 0: # get new direction
		thug_wannabe = randi_range (50, 320)
		random_direction = randi_range (1, 4)
		if randf() < 0.4: # sometimes walk, sometimes idle
			animation_state = "idle"
			speed = speed_idle
			if randf() < 0.2: # sometimes the shade will make an ugly hiss
				audio.stream = hiss_sound
				audio.pitch_scale = randf_range (0.5, 1.5)
				audio.play() 
		else:
			animation_state = "walk"
			speed = speed_walk
		
		if in_danger: # need to run
			animation_state = "walk"
			speed = speed_danger
		
	if random_direction == 1: # down
		animation_player.play(animation_state + "_down")
		velocity = speed * Vector2.DOWN 
		shade_sprite.flip_h = false
	elif random_direction == 2: # up
		animation_player.play(animation_state + "_up")
		velocity = speed * Vector2.UP 
		shade_sprite.flip_h = false
	elif random_direction == 3: # right
		animation_player.play(animation_state + "_side")
		velocity = speed * Vector2.RIGHT
		shade_sprite.flip_h = false
	elif random_direction == 4: # left
		animation_player.play(animation_state + "_side")
		velocity = speed * Vector2.LEFT
		shade_sprite.flip_h = true
	else:
		velocity = speed * Vector2.DOWN #  down
	

func _physics_process(_delta):
	update_direction()
	move_and_slide()
	if get_slide_collision_count() > 0:
		thug_wannabe = 0 # get a new random direction
		var collided_with = get_slide_collision(0)
		#print("collided_with: ", collided_with.get_collider().name) 
		if collided_with.get_collider().name == "Player": # play a hissing sound if the player is there
			in_danger = true
			audio.stream = hiss_sound
			audio.pitch_scale = randf_range (0.5, 1.5)
			audio.play() 
			
	
	
