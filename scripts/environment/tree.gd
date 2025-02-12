extends StaticBody2D

@onready var animatedSprite2d = $AnimatedSprite2D
@export var wood: InvItem
var health = 3
var woodCollected = false

func _ready() -> void:
	add_to_group("trees")
	
func _process(delta: float) -> void:
	if health == 0 : _death()
	
func _death():
	if health > 0: return
	animatedSprite2d.play("death")
	var player = get_tree().get_first_node_in_group("player")
	if not woodCollected:
		player.collect(wood)
		woodCollected = true

func getHit(playerDirectionX):
	if health == 0: return
	animatedSprite2d.flip_h = playerDirectionX == 1
	animatedSprite2d.play("chop")
	health -= 1

func _on_animated_sprite_2d_animation_finished() -> void:
	animatedSprite2d.flip_h = false
	animatedSprite2d.play("idle")
