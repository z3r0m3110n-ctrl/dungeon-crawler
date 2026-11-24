class_name Playground extends Node2D

@onready var game_over_screen: Node2D = $UI/GameOver
@onready var player: Player = $Player
@onready var hud: CanvasLayer = $HUD


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_screen.hide()
	hud.show()
	# Set the player starting position
	player.global_position = Vector2(randi_range(0,700),randi_range(000,500))#Vector2(500, 300)
	player.HealthChanged.connect(GameOver)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func GameOver() -> void:
	if player.health <= 0: # an inglorious defeat
		print("game over")
		player.animation_player.play("die_" + player.AnimDirection())# the hero has been vanquished
		await get_tree().create_timer(3).timeout
		game_over_screen.show()
		hud.hide()
		get_tree().paused = true
