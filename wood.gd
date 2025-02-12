extends StaticBody2D

@export var item: InvItem

var player = null

func _on_wood_interaction_body_entered(body: CharacterBody2D) -> void:
	player = body
	PlayerCollect()
	await get_tree().create_timer(0.1).timeout
	self.queue_free()	
		
func PlayerCollect(): 
	player.collect(item)
