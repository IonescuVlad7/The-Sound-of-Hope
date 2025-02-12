extends Area2D


func _on_body_entered(body: CharacterBody2D) -> void:
	body.z_index = 150


func _on_body_exited(body: CharacterBody2D) -> void:
	body.z_index = 1
