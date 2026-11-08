class_name Shade extends CharacterBody2D
# TODO: add more agressive behavior and an attack function
# Going to have to remove "in danger" once attacking is implemented :(
# TODO: Make a proper state machine once everything is working
# In WANDERING the shade will walk around the map, and occasionally idle. In CHASING the shade 
# will, upon seeing the player, re-use the same walking speed for "danger", until it reaches the 
# player and starts the ATTACKING phase upon reaching them, and claw the player until the player 
# lies dead. It will then return to WANDERING.
enum ShadeState  {
	WANDERING, 
	CHASING,
	ATTACKING
} 
var current_state : ShadeState = ShadeState.WANDERING

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

var monster_sight = 500 #300 # This is how far the enemy will see the player.
var the_prey_is_in_sight : bool = false



var hiss_sound = preload("res://enemies/audio/hiss.wav")

var player : Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var shade_sprite: Sprite2D = $Shade
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	health = randi_range(3,7) # set random amount of health
	$HitBox.Damaged.connect(TakeDamage)
	animation_player.play("idle_down")
	
	# find the player
	player = get_tree().get_first_node_in_group("Player")
	
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
	if current_state == ShadeState.WANDERING:
		wandering()
	elif current_state == ShadeState.CHASING:
		chasing()
	

func _physics_process(_delta):
	if player == null:
		current_state = ShadeState.WANDERING
	
	var distance_to_player = global_position.distance_to(player.global_position)
	print("Distance: ", distance_to_player)
	if current_state == ShadeState.WANDERING: # stop this guy from flipping around
		if distance_to_player < monster_sight: 
			current_state = ShadeState.CHASING
	elif current_state == ShadeState.CHASING:
			if distance_to_player > monster_sight + 50: 
				current_state = ShadeState.WANDERING
	
	update_direction()
	move_and_slide()
	
	if get_slide_collision_count() > 0: # this should be attacking, but run away for now
		thug_wannabe = 0 # get a new random direction
		var collided_with = get_slide_collision(0)
		#print("collided_with: ", collided_with.get_collider().name) 
		if collided_with.get_collider().name == "Player": # play a hissing sound if the player is there
			audio.stream = hiss_sound
			audio.pitch_scale = randf_range (0.5, 1.5)
			audio.play() 
			in_danger = true # in danger - be fast, don't idle
			# wait 10 seconds to see if safe
			await get_tree().create_timer(10.0).timeout
			in_danger = false
			
			
func wandering(): 	
	print("wandering")
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
	
	shade_sprite.flip_h = false	
	if random_direction == 1: # down
		animation_player.play(animation_state + "_down")
		velocity = speed * Vector2.DOWN 
	elif random_direction == 2: # up
		animation_player.play(animation_state + "_up")
		velocity = speed * Vector2.UP 
	elif random_direction == 3: # right
		animation_player.play(animation_state + "_side")
		velocity = speed * Vector2.RIGHT
	elif random_direction == 4: # left
		animation_player.play(animation_state + "_side")
		velocity = speed * Vector2.LEFT
		shade_sprite.flip_h = true
	else:
		velocity = speed * Vector2.DOWN #  down

func chasing():
	animation_state = "walk"
	speed = speed_danger
	
	direction = global_position.direction_to(player.global_position)
	print("direction: ", direction)
	
	shade_sprite.flip_h = false
	if abs(direction.x) > abs(direction.y): # mostly moving left or right
		if direction.x < 0:
			print("chasing left")
			velocity = speed * Vector2.LEFT
			shade_sprite.flip_h = true
		else:
			print("chasing right")
			animation_player.play(animation_state + "_side")
			velocity = speed * Vector2.RIGHT
	elif direction.y > 0: # mostly moving down
		print("chasing down")
		velocity = speed * Vector2.DOWN 
		animation_player.play(animation_state + "_down")
	else:
		print("chasing up")
		animation_player.play(animation_state + "_up")
		velocity = speed * Vector2(direction.x, direction.y)
