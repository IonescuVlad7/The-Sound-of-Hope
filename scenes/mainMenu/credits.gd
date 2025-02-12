extends Control

@export var mainMenu = "res://scenes/mainMenu/mainMenu.tscn"

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file(mainMenu)
