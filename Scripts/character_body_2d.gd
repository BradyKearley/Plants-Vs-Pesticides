extends CharacterBody2D
@export var bulletScene: PackedScene
var SPEED = 600.0
const JUMP_VELOCITY = -400.0
var canDash = true
var canShoot = true
var dashSpeed = 1
var dashCooldown
var health = 100
var invincible = false
var inBossRange = false
var my_random_number = null
var rng = RandomNumberGenerator.new()
@onready var background_music = $AudioStreamPlayer2D
@onready var boss_music = $AudioStreamPlayer2D2
@export var Main :AudioStreamMP3
@export var Boss :AudioStreamMP3
func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
func _process(delta: float) -> void:
	if health <=0:
		get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	if Input.is_action_pressed("Shoot"):
		shoot()
func _physics_process(delta: float) -> void:
	# Handle jump.
	if dashSpeed > 1:
		dashSpeed -= .5
		
	if canDash:
		$CanvasLayer/Dash.play("Green")
	else:
		$CanvasLayer/Dash.play("Red")
		
	if Input.is_action_just_pressed("ui_accept") and canDash:
		dashSpeed = 6
		invincible = true
		$InvinciblityTimer.start()
		$DashSound.play()
		canDash = false
		$DashTimer.start()
	var direction := Vector2(
		Input.get_action_strength("D") - Input.get_action_strength("A"),
		Input.get_action_strength("S") - Input.get_action_strength("W")
	)

	if direction.length() > 1.0:
		direction = direction.normalized()
	velocity = direction * SPEED * dashSpeed
	move_and_slide()


func _on_dash_timer_timeout() -> void:
	canDash = true
	$DashRechargeSound.play()
	$DashTimer.stop()
func reduceDashCooldown(reduction:int):
	$DashTimer.wait_time -=reduction
	
func shoot():
	if canShoot:
		canShoot = false
		$ShootSound.play()
		$ShootTimer.start()
		var bullet = bulletScene.instantiate()
		bullet.global_position = global_position  # Set bullet spawn position
		
		bullet.initialize((get_global_mouse_position() - global_position).normalized())  # Set direction
		bullet.look_at(get_global_mouse_position())
		get_parent().add_child(bullet)  # Add the bullet to the scene


func _on_shoot_timer_timeout() -> void:
	$ShootTimer.stop()
	canShoot = true
	pass # Replace with function body.



func _on_bounding_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		area.queue_free()
		


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and invincible == false:
		health -= 5
		modulate = Color(255,0,0)
		$RedFlashTimer.start()
	if area.is_in_group("Tree"):
		inBossRange = true
		switch_to_boss_music()
	elif area.is_in_group("powerUp"):
		my_random_number = rng.randf_range(0, 4)
		print(my_random_number)
		if my_random_number <= 1:
			health += 15
			print('hp')
			$PowerUpLabel.text = "15% Heal!"
			$PowerUpLabel.show()
			$PowerUpTimer.start()
			if health > 100:
				health = 100
				
		elif my_random_number <= 2 && my_random_number > 1:
			SPEED += 150
			$PowerUpLabel.text = "+150 Speed!"
			$PowerUpLabel.show()
			$PowerUpTimer.start()
			print('sp')
		elif my_random_number <= 3 && my_random_number > 2:
			$ShootTimer.wait_time -= 0.5
			$PowerUpLabel.text = "Fire Rate Up!"
			$PowerUpLabel.show()
			$PowerUpTimer.start()
			print('st')
		elif my_random_number <= 4 && my_random_number > 3:
			$DashTimer.wait_time -= 0.5
			$PowerUpLabel.text = "Dash Faster!"
			$PowerUpLabel.show()
			$PowerUpTimer.start()
			print('ds')


func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("Tree"):
		inBossRange = false
		switch_to_background_music()
# Function to switch to boss music
func switch_to_boss_music():
	if background_music.playing:
		background_music.stop()
	boss_music.play()

# Function to switch back to background music
func switch_to_background_music():
	if boss_music.playing:
		boss_music.stop()
	background_music.play()

func _on_invinciblity_timer_timeout() -> void:
	invincible = false


func _on_regen_timer_timeout() -> void:
	health +=1


func _on_red_flash_timer_timeout() -> void:
	modulate = Color(1,1,1)
	$RedFlashTimer.stop()


func _on_power_up_timer_timeout() -> void:
	$PowerUpLabel.hide()
