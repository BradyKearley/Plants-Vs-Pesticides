extends Control


@onready var main_menu_button = $PanelContainer/VBoxContainer/MainMenu as Button
@onready var quit_button = $PanelContainer/VBoxContainer/Quit as Button




# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu_button.button.down.connect(on_main_menu_button_down)
	quit_button.button_down.connect(on_quit_button_down)


func on_main_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	
	
func on_quit_button_down() -> void:
	get_tree().quit()
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
