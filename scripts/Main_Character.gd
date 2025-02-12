extends CharacterBody2D

@export var inv: Inv

#@onready var inventory = $Inventory
#@onready var inventory_ui = get_node("Inventory/Control")
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var damage_box = $damage_box

var WALK_SPEED = 200
var SPRINT_SPEED = 350
var facing_direction = "down"
var is_sprinting = false
var anotherAnimationOngoing = false
var lantern = false

func _ready() -> void:
	animation_player.play("idle down")

func _physics_process(delta):

	var SPEED = WALK_SPEED
	if is_sprinting:
		SPEED = SPRINT_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_horizontal = Input.get_axis("ui_left", "ui_right")
	var direction_vertical = Input.get_axis("ui_up", "ui_down")
	
	if not anotherAnimationOngoing:
		if direction_horizontal != 0:
			velocity.x = direction_horizontal * SPEED
			if direction_horizontal > 0:
				animation_player.play("run right" if is_sprinting else "walk right")
				facing_direction = "right"
			elif direction_horizontal < 0:
				animation_player.play("run left" if is_sprinting else "walk left")
				facing_direction = "left"
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if direction_vertical != 0:
			velocity.y = direction_vertical * SPEED
			if direction_vertical > 0:
				animation_player.play("run down" if is_sprinting else "walk down")
				facing_direction = "down"
			elif direction_vertical < 0:
				animation_player.play("run up" if is_sprinting else "walk up")
				facing_direction = "up"
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		if direction_horizontal == 0 and direction_vertical == 0:
			animation_player.play("idle " + facing_direction)
		# Use move_and_slide for movement
		move_and_slide()
	if get_node_or_null("../Main_Character/PointLight2D") != null:
		if lantern:
			$PointLight2D.enabled = true
		else:
			$PointLight2D.enabled = false
	
	
func _input(event):
	if event.is_action_pressed("chop"):
		_do_chop()
	if event.is_action_pressed("sprint_toggle"):
		is_sprinting = !is_sprinting	
	if event.is_action_pressed("lantern_toggle"):
		lantern = !lantern
	if event.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/mainMenu/mainMenu.tscn")
		
func collect(item):
	inv.insert(item)

func remove(item):
	inv.remove(item)
	
func searchForItem(item):
	return inv.searchForItem(item)
	
func playAnimation(animation: String):
	animation_player.play(animation)
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("idle down")
	$Body.flip_h = false
	$Body/Shirt.flip_h = false
	$Body/Hair.flip_h = false
	$Body/Pants.flip_h = false
	anotherAnimationOngoing = false

func _do_chop():
	if anotherAnimationOngoing: return
	
	anotherAnimationOngoing = true
	if facing_direction == "right":
		animation_player.play("swing right axe")
	else:
		animation_player.play("swing left axe")
	_hit_tree()
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


#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#animation_player.play("idle down")
	##animation_player.flip_h = false

func _hit_tree():
	var hasCollision = len(damage_box.get_overlapping_bodies()) > 0
	if not hasCollision: return
	
	var collisionBody = damage_box.get_overlapping_bodies()[0]
	
	if collisionBody in get_tree().get_nodes_in_group("trees"):
		if facing_direction == "right":
			collisionBody.getHit(1)
		else:
			collisionBody.getHit(-1)
	
