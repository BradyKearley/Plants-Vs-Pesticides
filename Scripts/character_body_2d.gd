extends CharacterBody2D
@export var bulletScene: PackedScene
const SPEED = 600.0
const JUMP_VELOCITY = -400.0
var canDash = true
var canShoot = true
var dashSpeed = 1
var dashCooldown
var health = 100

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
func _process(delta: float) -> void:
	if health <=0:
		get_tree().quit()
	
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	if Input.is_action_just_pressed("Shoot"):
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
		dashSpeed = 4
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
	$DashTimer.stop()
func reduceDashCooldown(reduction:int):
	$DashTimer.wait_time -=reduction
	
	
func shoot():
	if canShoot:
		canShoot = false
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
	if area.is_in_group("enemy"):
		health -= 25
		print(health)
