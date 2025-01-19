extends Area2D

# Rotation speed in degrees per second
@export var rotation_speed: float = 20.0

func _process(delta: float) -> void:
	# Rotate the node by rotation_speed * delta
	rotation_degrees += rotation_speed * delta
