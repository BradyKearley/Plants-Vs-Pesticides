extends CharacterBody2D

var plant_speed = 200
var player_detected = false
var player: Node2D = null
var stop_distance = 100  # Minimum distance to stop moving
var health = 100
const maxHealth = 100
var stunnded = false
var rotation_speed = 360  
var target_rotation = 0.0  
var spinning = false    

func spin_360():
	if spinning:
		return  # Prevent triggering another spin while already spinning
	spinning = true
	target_rotation = rotation + deg_to_rad(360)
func _process(delta: float) -> void:
	if spinning:
		# Incrementally rotate the sprite
		var step = rotation_speed * delta
		rotation += deg_to_rad(step)

		# Check if the target rotation is reached
		if rotation >= target_rotation:
			rotation = target_rotation  # Snap to the target rotation
			spinning = false  # Stop spinning

func _ready() -> void:
	$StunTimer.stop()
	$AnimatedSprite2D.play("idle")
func _physics_process(delta):
	if player_detected and player and not stunnded:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player > stop_distance:
			var direction = (player.position - position).normalized()
<<<<<<< HEAD
			velocity= direction * plant_speed
	if not stunnded:
		move_and_slide()
=======
			position += direction * plant_speed * delta
>>>>>>> f7f188432216529a01592353ea118e2c01623536

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
	$StunTimer.start()
	spin_360()
	stunnded = true


func _on_stun_timer_timeout() -> void:
	stunnded = false
	$StunTimer.stop()
