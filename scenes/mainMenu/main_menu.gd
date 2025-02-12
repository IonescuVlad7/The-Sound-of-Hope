class_name MainMenu
extends Control

@onready var startButton = $MarginContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var exitButton = $MarginContainer/HBoxContainer/VBoxContainer/ExitButton as Button
@onready var creditsButton = $MarginContainer/HBoxContainer/VBoxContainer/CreditsButton as Button

@export var creditsScene = "res://scenes/mainMenu/credits.tscn" 
@export var startLevel = preload("res://scenes/map1Stuff/map1Node.tscn") as PackedScene

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	startButton.button_down.connect(onStartPressed)
	exitButton.button_down.connect(onExitPressed)
	
func onStartPressed():
	get_tree().change_scene_to_packed(startLevel)
	
func onExitPressed():
	get_tree().quit()


func _on_credits_button_down() -> void:
	get_tree().change_scene_to_file(creditsScene)
