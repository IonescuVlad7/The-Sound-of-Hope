extends CharacterBody2D

@export var inv: Inv

#@onready var inventory = $Inventory
#@onready var inventory_ui = get_node("Inventory/Control")
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const INPUT_HOE_USE = "hoe_use"

func _physics_process(delta):

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_horizontal = Input.get_axis("ui_left", "ui_right")
	var direction_vertical = Input.get_axis("ui_up", "ui_down")
	if direction_horizontal:
		velocity.x = direction_horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_vertical:
		velocity.y = direction_vertical * SPEED
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_pressed("ui_up"):
		animated_sprite.animation = "idle_up"

	elif Input.is_action_pressed("ui_left"):
		animated_sprite.animation = "idle_left"
	elif Input.is_action_pressed("ui_down"):
		animated_sprite.animation = "idle_down"
	elif Input.is_action_pressed("ui_right"):
		animated_sprite.animation = "idle_right"

	move_and_slide()
	
func _input(event):
	pass
	#if event is InputEventKey and event.pressed and event.keycode == KEY_TAB:
		#print("Tab key pressed")
		#inventory_ui.toggle_inventory()
		
func collect(item):
	inv.insert(item)
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

func _ready():
	velocity = Vector2.ZERO
	set_process(true)
	set_process_input(true)
	set_physics_process(true)
