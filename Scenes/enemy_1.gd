extends CharacterBody2D

var plant_speed = 25
var player_detected = false
var player = null

func _physics_process(delta):
	if player_detected:
		position += (player.position -position)/plant_speed

func _on_detection_roots_body_entered(body: Node2D) -> void:
	player_found = true
	player = body

func _on_detection_roots_body_exited(body: Node2D) -> void:
	player_found = true
	player = null
