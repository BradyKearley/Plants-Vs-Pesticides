extends TextureProgressBar
func _ready() -> void:
	max_value = get_parent().maxHealth
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = get_parent().health
