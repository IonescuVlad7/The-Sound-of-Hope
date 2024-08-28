extends CharacterBody2D

@onready var inventory = $Control
@onready var inventory_ui = get_node("Control")
@onready var animated_sprite = $AnimatedSprite2D

const INPUT_HOE_USE = "hoe_use"

var WALK_SPEED = 100
var SPRINT_SPEED = 250
var facing_direction = "down"
var is_sprinting = false

func _input(event):
	if event.is_action_pressed("sprint_toggle"):
		is_sprinting = !is_sprinting
	if event is InputEventKey and event.pressed and event.keycode == KEY_TAB:
		toggle_inventory()

func _physics_process(delta):
	
	var SPEED = WALK_SPEED
	if is_sprinting:
		SPEED = SPRINT_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_horizontal = Input.get_axis("ui_left", "ui_right")
	var direction_vertical = Input.get_axis("ui_up", "ui_down")
	
	if direction_horizontal != 0:
		velocity.x = direction_horizontal * SPEED
		if direction_horizontal > 0:
			animated_sprite.animation = "run_right" if is_sprinting else "walk_right"
			facing_direction = "right"
		elif direction_horizontal < 0:
			animated_sprite.animation = "run_left" if is_sprinting else "walk_left"
			facing_direction = "left"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_vertical != 0:
		velocity.y = direction_vertical * SPEED
		if direction_vertical > 0:
			animated_sprite.animation = "run_down" if is_sprinting else "walk_down"
			facing_direction = "down"
		elif direction_vertical < 0:
			animated_sprite.animation = "run_up" if is_sprinting else "walk_up"
			facing_direction = "up"
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction_horizontal == 0 and direction_vertical == 0:
		animated_sprite.animation = "idle_" + facing_direction

	position += velocity * delta

func toggle_inventory():
	if inventory.visible:
		inventory.hide()
	else:
		inventory.show()

#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		#use_hoe(event.position)
#
#func use_hoe(mouse_pos):
	#var space_state = get_world_2d().direct_space_state
	#var result = space_state.intersect_ray(global_position, mouse_pos)
	#if result:
		#var tile_pos = get_global_mouse_position()
		#var tilemap = get_parent().get_node("World/Dirt")
		#var tile_coord = tilemap.world_to_map(tile_pos)
		#tilemap.set_cell(tile_coord.x, tile_coord.y, TILE_PLANTABLE_DIRT)
