class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@export var max_health: int = 100
var health : int = 100
var limit_left : int = 0
var limit_right : int = 0
var limit_top : int = 0
var limit_bottom : int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var tilemap: LevelTileMap = $"../Environment/Grass"
@export var maxhealth : int = 100
@onready var particles: CPUParticles2D = $CPUParticles2D

signal DirectionChanged(new_direction : Vector2)
signal HealthChanged()

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Initialize(self)
	LevelManager.TileMapBoundsChanged.connect(UpdateLimits)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()

	
func _physics_process(_delta):
	if health < 0:
		return
		
	move_and_slide()
	
	# Keep the player on the grass tileset
	var margin = 50 # add a margin to the boundary
	global_position.x = clamp(global_position.x, limit_left + margin, limit_right - margin)
	global_position.y = clamp(global_position.y, limit_top + margin, limit_bottom - margin)
	
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	sprite.scale.x = -2.0 if cardinal_direction == Vector2.LEFT else 2.0
	return true
	
func UpdateAnimation( state : String ) -> void:
	animation_player.play(state + "_" + AnimDirection())


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"


func GetHurt(damage : int) -> void:
	
	if damage > 0:
		# show blood particle effect
		if health > 0:
			particles.amount = 20 #50
			particles.scale_amount_min = 0.2
			particles.scale_amount_max = 0.5
			particles.gravity = Vector2.ZERO
			particles.one_shot = true
			particles.explosiveness = 1.0
			particles.direction = Vector2.RIGHT
			particles.spread = 180.0 #360.0
			particles.initial_velocity_min = 30.0;
			particles.initial_velocity_max = 60.0;
			particles.radial_accel_min = 0.0;
			particles.radial_accel_max = 20.0;
			particles.tangential_accel_min = 0.0;
			particles.tangential_accel_max = 20.0;
			particles.damping_min = 30.0;
			particles.damping_max = 0.0;
			particles.lifetime = 0.6
			particles.emitting = true
	
	# lose health if damage is positive, otherwise gain health
	health  -= damage
	health = clampi(health, 0, 100)
	
	print ("PlayerHealth", health)
	HealthChanged.emit()
	

	
func UpdateLimits(bounds : Array[Vector2]) -> void:
	if bounds == []:
		return # there are no bounds
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
