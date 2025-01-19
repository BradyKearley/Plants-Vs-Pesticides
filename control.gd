extends Control


@onready var main_menu_button = $PanelContainer/VBoxContainer/MainMenu as Button
@onready var quit_button = $PanelContainer/VBoxContainer/Quit as Button

func setScore():

	var points = (get_parent().get_parent().health * 1000000) / get_parent().get_child(3).time
	$PanelContainer/VBoxContainer/Label.text = "Score : " + str(points)


# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu_button.button_down.connect(on_main_menu_button_down)
	quit_button.button_down.connect(on_quit_button_down)
	hide()
func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func on_main_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	
	
func on_quit_button_down() -> void:
	get_tree().quit()
	




func _on_tree_tree_die() -> void:
	pause()
	$AudioStreamPlayer.play()
	setScore()
	show()
	pass # Replace with function body.
