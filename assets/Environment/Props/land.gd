extends StaticBody2D

var isLandHoed = false
var isLandWatered = false
var isPlantGrowing = false
var isPlantGrown = false
var inventory = null
var canInteract = true
@onready var interactionArea = $InteractionArea
@export var seed: InvItem 

@export var carrot: InvItem

@export var waterCan: InvItem

var player = null

func _ready() -> void:
	
	interactionArea.interact = Callable(self,"_use_land")
	$land.play("emptyLand")
	$water.play("notWatered")
	$growingPlant.play("notPlanted")
	$land.frame = 0
	$carrotGrowTimer.wait_time = 3.0
	
func _process(delta: float) -> void:
	pass

func _use_land():
	player = get_tree().get_first_node_in_group("player")
	if not isLandHoed:
		print("Land HOED")
		isLandHoed = true
		if player.facing_direction == "right":
			player.playAnimation("swing right hoe")
		else:
			player.playAnimation("swing left hoe")
		player.anotherAnimationOngoing = true
		$land.frame = 1
		pass
	elif not isLandWatered:
		if player.searchForItem(waterCan) > 0:
			isLandWatered = true;
			player.remove(waterCan)
			print("Land WATERED")
			if player.facing_direction == "right":
				player.playAnimation("water right")
			else:
				player.playAnimation("water left")
			player.anotherAnimationOngoing = true
			$water.play("watered")
			$water.frame = randi_range(0,2)
			pass
		else: 
			print("Watering can is empty!")
	elif not isPlantGrowing:
		print("Planted the seed") 
		var seedExists = checkIfSeedExists()
		if seedExists:
			$carrotGrowTimer.start()
			$growingPlant.play("growingCarrot")
			isPlantGrowing = true
	if isPlantGrown:
		print("Plant collected")
		isLandHoed = false
		isPlantGrowing = false
		isPlantGrown = false
		isLandWatered = false
		$growingPlant.play("notPlanted")
		$land.frame = 0
		$water.play("notWatered")
		collectCarrot()
		
	
	if isLandHoed && !isLandWatered && !isPlantGrowing && !isPlantGrown:
		$InteractionArea.action_name = "water"
	elif isLandHoed && isLandWatered && !isPlantGrowing && !isPlantGrown:
		$InteractionArea.action_name = "plant"
	elif isLandHoed && isLandWatered && isPlantGrowing && $growingPlant.frame != 3:
		InteractionManager.base_text = ""
		$InteractionArea.action_name = ""
	elif isLandHoed && isLandWatered && isPlantGrowing && $growingPlant.frame == 3:
		InteractionManager.base_text = "[E] to "
		$InteractionArea.action_name = "collect"
	elif !isLandHoed && !isLandWatered && !isPlantGrowing && !isPlantGrown:
		$InteractionArea.action_name = "hoe"

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if isPlantGrowing && $growingPlant.frame != 3:
		InteractionManager.base_text = ""
	else :
		InteractionManager.base_text = "[E] to "


func _on_carrot_grow_timer_timeout() -> void:
	var growingPlant = $growingPlant
	print("Plant growing")
	if growingPlant.frame == 0:
		growingPlant.frame = 1
		$carrotGrowTimer.start()
	elif growingPlant.frame == 1:
		growingPlant.frame = 2
		$carrotGrowTimer.start()
	elif growingPlant.frame == 2:
		growingPlant.frame = 3
		isPlantGrown = true
		InteractionManager.base_text = "[E] to "
		$InteractionArea.action_name = "collect"
		$carrotGrowTimer.stop()

func collectCarrot():
	player = get_tree().get_first_node_in_group("player")
	player.collect(carrot)

func checkIfSeedExists():
	player = get_tree().get_first_node_in_group("player")
	var itemSlots = player.inv.slots.filter(func(slot): return slot.item == seed)
	if (!itemSlots.is_empty()):
		player.remove(seed)
		return true
	return false
	
