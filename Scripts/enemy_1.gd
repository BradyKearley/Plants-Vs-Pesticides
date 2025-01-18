extends CharacterBody2D

var plant_speed = 200
var player_detected = false
var player: Node2D = null
var stop_distance = 100  # Minimum distance to stop moving
var health = 100
var stunnded = false
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
func _physics_process(delta):
	if player_detected and player and not stunnded:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player > stop_distance:
			var direction = (player.position - position).normalized()
			position += direction * plant_speed * delta

func _on_detection_roots_body_entered(body: Node2D) -> void:
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
	stunnded = true


func _on_stun_timer_timeout() -> void:
	stunnded = false
	$StunTimer.stop()
