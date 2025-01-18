extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0
var canDash = true
var dashSpeed = 1
var dashCooldown
func _physics_process(delta: float) -> void:
	# Handle jump.
	if dashSpeed > 1:
		dashSpeed -= .5
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
