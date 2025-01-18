extends CharacterBody2D

var plant_speed = 200
var player_detected = false
var player = null

func _physics_process(delta):
	if player_detected && player:
		var direction = (player.position - position).normalized()
		position += direction * plant_speed * delta

func _on_detection_roots_body_entered(body: Node2D) -> void:
	player_detected = true
	player = body
 

func _on_detection_roots_body_exited(body: Node2D) -> void:
	player_detected = true
	player = null
