class_name MainMenu
extends Control


@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
@export var start_game = PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(on_start_button_down)
	exit_button.button_down.connect(on_exit_button_down)


func on_exit_button_down() -> void:
	get_tree().quit()
	
func on_start_button_down() -> void:
	get_tree().change_scene_to_packed(start_game)
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
