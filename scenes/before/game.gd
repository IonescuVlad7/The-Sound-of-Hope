extends Node2D

@onready var player = $Main_Character
@onready var initial_map = $home_area

var current_map: Node2D = null

func _ready():
	# Load the initial map
	load_map(initial_map)

func load_map(map_node: Node2D):
	if current_map != null:
		current_map.visible = false

	current_map = map_node
	current_map.visible = true

	# Connect teleport areas in the new map
	for area in current_map.get_children():
		if area is Area2D:
			area.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(area):
	if area == player:
		_on_TeleportArea_body_entered(area)

func _on_TeleportArea_body_entered(area):
	# Access the custom properties from the area
	var next_map_path = area.next_map  # Custom property
	var next_position = area.next_position  # Custom property

	# Hide current map
	current_map.visible = false

	# Load the next map
	var next_map = get_node(next_map_path)
	load_map(next_map)
	
	# Move the player to the new position
	player.global_position = next_position
