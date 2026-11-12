class_name HealthBar extends ProgressBar

@onready var player = get_node("../../Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	player.HealthChanged.connect(update)
	
	
func update():
	value = round((player.health* 100) / player.max_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
