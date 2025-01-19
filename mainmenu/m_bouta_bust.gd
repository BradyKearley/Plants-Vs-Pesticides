extends CharacterBody2D

var plant_speed = 400
var player_detected = false
var player: Node2D = null
var stop_distance = 100  # Minimum distance to stop moving
var health = 25
const maxHealth = 25
var stunnded = false
var rotation_speed = 360  
var target_rotation = 0.0  
var expload = false

func _ready() -> void:
	$StunTimer.stop()
	$AnimatedSprite2D.play("idle")
	velocity = Vector2.ZERO  # Ensure velocity starts at zero

func _physics_process(delta):
	if player_detected and player and not stunnded:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player > stop_distance:
			var direction = (player.position - position).normalized()
			velocity = direction * plant_speed
		else:
			velocity = Vector2.ZERO  # Stop movement when within stop distance
	else:
		velocity = Vector2.ZERO  # Stop movement when no player is detected

	if not stunnded:
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
	if health <= 0:
		queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$StunTimer.start()
		$AnimatedSprite2D.play("Explode")
		expload = true
		stunnded = true
		velocity = Vector2.ZERO  # Stop movement immediately

func _on_stun_timer_timeout() -> void:
	stunnded = false
	$StunTimer.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if expload:
		$AnimatedSprite2D.play("idle")
		expload = false
