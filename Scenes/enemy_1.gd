extends CharacterBody2D

var plant_speed = 200
var player_detected = false
var player: Node2D = null
var stop_distance = 100  # Minimum distance to stop moving

func _physics_process(delta):
	if player_detected and player:
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
