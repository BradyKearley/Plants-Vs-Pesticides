extends CharacterBody2D
@export var MrBust : PackedScene   
@export var Treebullet : PackedScene   
@export var Branch : PackedScene
var player_detected = false
var player: Node2D = null
var stop_distance = 100  
var health = 1000
const maxHealth = 1000
var phase = 1
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	$AttackTimer.start()
	$SpawnTimer.start()
	
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
	if health < 500 and phase == 1:
		spawnGrout()
		phase = 2
	if health < 250 and phase == 2:
		spawnGrout()
		phase = 3
func spawn():
	var busterBus = MrBust.instantiate()
	add_child(busterBus)
	busterBus.global_position = global_position + Vector2(randi_range(-100,25),randi_range(-25,25))
	
func shoot():
		# Define the starting angle (in radians)
	var angle = 0.0

	# Define the increment for each bullet (how much the angle changes per bullet)
	var angle_increment = 0.5  # Adjust this value to control the spiral tightness

	# Define the speed multiplier for the bullets
	var speed = 200  # Adjust this as needed

	# Spawn bullets in a spiral pattern
	for i in range(32):  # Number of bullets you want to shoot in one "spiral"
		# Instance the bullet
		var bullet = Treebullet.instantiate()
		# Add the bullet as a child of the current node
		add_child(bullet)
		# Set the bullet's position to the spawner's position
		bullet.global_position = global_position

		# Calculate the direction using the current angle
		var direction = Vector2(cos(angle), sin(angle))
		
		# Initialize the bullet with the calculated direction and speed
		bullet.initialize(direction.normalized() * speed)

		# Increment the angle for the next bullet
		angle += angle_increment


func _on_attack_timer_timeout() -> void:
	if player_detected:
		shoot()


func _on_spawn_timer_timeout() -> void:
	if player_detected:
		spawn()
func spawnGrout():
	var Grout = Branch.instantiate()
	add_child(Grout)
	Grout.global_position = global_position
	
