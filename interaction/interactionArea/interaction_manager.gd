extends Node2D

@onready var player = null
@onready var label = $Label

@export var base_text = "[E] to "

func get_player() -> Node2D:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		if player == null:
			push_error("Player node not found in group 'player'.")
	return player

var active_areas = []
var can_interact = true

func register_area (area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area (area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide() 

func _sort_by_distance_to_player(area1, area2):
	player = get_player()
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return sign(area1_to_player - area2_to_player)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call() 
			
			can_interact = true
		
