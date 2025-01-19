extends CanvasLayer
@onready var health_bar = $HealthBar
@onready var timeLabel = $Time
@onready var dash_sprite = $Dash  # Assuming your sprite node is called DashSprite
func _process(delta: float) -> void:
	var screen_size = get_viewport().get_visible_rect().size
	# Set the position of the sprite to the bottom-right corner
	dash_sprite.position = screen_size - Vector2(75,75)
	health_bar.position = screen_size - Vector2(450,165)
	timeLabel.position = screen_size - Vector2((screen_size.x/2),1080)
	health_bar.value = get_parent().health
