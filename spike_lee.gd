extends CharacterBody2D
@export var spike : PackedScene   
var plant_speed = 150
var player_detected = false
var player: Node2D = null
var stop_distance = 100  # Minimum distance to stop moving
var health = 150
const maxHealth = 150
var stunnded = false
  



func _ready() -> void:
	$StunTimer.stop()
	$ShootTimer.start()
	$AnimatedSprite2D.play("idle")
	
func _physics_process(delta):
	if player_detected and player and not stunnded:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player > stop_distance:
			var direction = (player.position - position).normalized()
			velocity = direction * plant_speed 
	move_and_slide()

func _on_detection_roots_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = true
		player = body

func _on_detection_roots_body_exited(body: Node2D) -> void:
	if body == player:
		player_detected = false
		player = null

func hit():
	health -= 25
	print(health)
	if health <= 0:
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$StunTimer.start()
		stunnded = true


func _on_stun_timer_timeout() -> void:
	stunnded = false
	$StunTimer.stop()



func _on_shoot_timer_timeout() -> void:
	spawn_bullets_in_eight_directions()
func spawn_bullets_in_eight_directions():
	# Define the eight directions: up, down, left, right, and the four diagonals
	if player_detected:
		var directions = [
			Vector2(0, -1),  # Up
			Vector2(0, 1),   # Down
			Vector2(-1, 0),  # Left
			Vector2(1, 0),   # Right
			Vector2(-1, -1), # Diagonal Down-Left
			Vector2(1, -1),  # Diagonal Down-Right
			Vector2(-1, 1),  # Diagonal Up-Left
			Vector2(1, 1)    # Diagonal Up-Right
		]

		for direction in directions:
			# Instance the bullet
			var bullet = spike.instantiate()

			# Add the bullet as a child of the current node
			add_child(bullet)

			# Set the bullet's position to the spawner's position
			bullet.global_position = global_position

			# Initialize the bullet with the direction
			bullet.initialize(direction.normalized() * 1)
