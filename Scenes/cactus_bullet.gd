extends Area2D

# Speed of the bullet
@export var speed: float =500
# Direction of movement
var direction: Vector2 = Vector2.ZERO

# Called every frame
func _process(delta: float) -> void:
	# Move the bullet in the specified direction
	global_position += direction * speed * delta
	

# Initialize the bullet with its direction
func initialize(direction_vector: Vector2) -> void:
	direction = direction_vector.normalized()
	rotation = direction.angle()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
