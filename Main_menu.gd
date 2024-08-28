extends Control

func _ready():
	var playButton = $Play
	var exitButton = $Exit
	playButton.connect("pressed", Callable(self, "_on_PlayButton_pressed"))
	exitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))

func _on_PlayButton_pressed():
	# Load the game scene
	var gameScene = preload("res://scenes/game.tscn")
	
	# Transition to the game scene
	get_tree().change_scene_to_packed(gameScene)

func _on_ExitButton_pressed():
	# Quit the game
	get_tree().quit()
