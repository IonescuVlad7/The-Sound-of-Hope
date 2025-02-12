extends StaticBody2D

@onready var animatedSprite2d = $AnimatedSprite2D

func _ready() -> void:
	animatedSprite2d.play("death")
