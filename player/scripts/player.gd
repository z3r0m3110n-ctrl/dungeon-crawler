class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@export var max_health: int = 100
var health : int = 100
 

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var tilemap: LevelTileMap = $"../Environment/Grass"
@export var maxhealth : int = 100

signal DirectionChanged(new_direction : Vector2)
signal HealthChanged()

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Initialize(self)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()

	
func _physics_process(_delta):
	move_and_slide()
	
	# Get tilemap boundaries
	var used_rect = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size
	
	var margin = 15

	var min_pos = tilemap.to_global(
		Vector2(used_rect.position * tile_size)
	)

	var max_pos = tilemap.to_global(
		Vector2((used_rect.position + used_rect.size) * tile_size)
	)

	# Keep player inside boundaries
	global_position.x = clamp(global_position.x, min_pos.x + margin, max_pos.x - margin)
	global_position.y = clamp(global_position.y, min_pos.y + margin, max_pos.y - margin)
	
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
	health  -= damage
	print ("PlayerHealth", health)
	HealthChanged.emit()
	if health == 0:  # the hero has been vanquished
		get_parent().GameOver()
		#queue_free()
	
