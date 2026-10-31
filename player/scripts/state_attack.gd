class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@onready var walk : State = $"../Walk"
@onready var idle: State_Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"

## What happens when the player enters this State?
func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.8, 1.3)
	audio.play()
	attacking = true
	
	await get_tree().create_timer(0.15).timeout
	hurt_box.monitoring = true
	pass


## What happens when the player exits this State?
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass
	
	
func Physics( _delta : float) -> State:
	return null 
	
## What happens with input events in this State?
func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	#player.velocity =Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null
	
func HandleInput( _event: InputEvent ) -> State:
	return null

func EndAttack(_newAnimName : String) -> void:
	attacking = false
