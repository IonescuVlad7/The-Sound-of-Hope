extends TileMapLayer

func _ready():
	y_sort_children()

func y_sort_children():
	for child in get_children():
		if child is CharacterBody2D:
			child.z_index = -child.position.y
