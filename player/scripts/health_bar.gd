class_name HealthBar extends ProgressBar

@onready var player = get_node("../../Player")
@onready var bar_blood: CPUParticles2D = $BarBlood


# Called when the node enters the scene tree for the first time.
func _ready():
	player.HealthChanged.connect(update)
	
	
func update():
	value = round((player.health* 100) / player.max_health)
	# show the dripping blood effect
	bar_blood.one_shot = true
	bar_blood.amount = 5
	bar_blood.scale_amount_min = 0.5
	bar_blood.scale_amount_max = 0.8
	bar_blood.lifetime = 0.5 # make this number bigger for a longer drip
	bar_blood.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
