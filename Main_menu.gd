extends Control

func _ready():
	var playButton = $Play
	var exitButton = $Exit
	playButton.connect("pressed", Callable(self, "_on_PlayButton_pressed"))
	exitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))

func _on_PlayButton_pressed():
	pass

func _on_ExitButton_pressed():
	# Quit the game
	get_tree().quit()
