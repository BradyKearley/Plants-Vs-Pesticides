extends CanvasLayer

@onready var dash_sprite = $Dash  # Assuming your sprite node is called DashSprite
func _process(delta: float) -> void:
	var screen_size = get_viewport().get_visible_rect().size
	# Set the position of the sprite to the bottom-right corner
	dash_sprite.position = screen_size - Vector2(75,75)
