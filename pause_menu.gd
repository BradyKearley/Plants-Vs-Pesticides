extends Control

func _ready() -> void:
	hide()
func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused :
		print("Works")
		show()
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused :
		resume()
		hide()


func _on_resume_pressed() -> void:
	resume()
	hide()


func _on_restart_pressed() -> void:
	resume()
	hide()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta):
	testEsc()
