extends CharacterBody2D
@export var MrBust : PackedScene   
@export var bullet : PackedScene   
var player_detected = false
var player: Node2D = null
var stop_distance = 100  
var health = 500
const maxHealth = 500

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
func _process(delta: float) -> void:
	if player_detected:
		attack()
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
func attack():
	var busterBus = MrBust.instantiate()

	add_child(busterBus)
	bullet.global_position = global_position
	shoot()
func shoot():
	pass
