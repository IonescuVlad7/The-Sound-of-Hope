extends AnimatedSprite2D

@onready var interactionArea = $InteractionArea
@export var knife: InvItem
@export var waterCan: InvItem

var isFull = false
var isKnife = false
var isCan = false
var player = null
func _ready() -> void:
	interactionArea.interact = Callable(self,"_use_stand")
	$".".play("idle")
	$".".frame = 0
	isFull = false
	isKnife = false
	isCan = false

func _use_stand():
	player = get_tree().get_first_node_in_group("player")
	if not isKnife:
		isKnife = true
		player.remove(knife)
		$".".frame = 1
		pass
	elif not isCan:
		if player.searchForItem(waterCan) <=0:
			print(player.searchForItem(waterCan))
			$".".frame = 2
			$".".play("charging")
			$canFilledTimer.start()
			isCan = true
		pass
	if isFull:
		isFull = false
		isKnife = false
		isCan = false
		player.collect(knife)
		#adaug 5 stack-uri de apa si folosesc un stack de apa cand ud pamantul
		player.collect(waterCan)
		player.collect(waterCan)
		player.collect(waterCan)
		player.collect(waterCan)
		player.collect(waterCan)
		$".".play("idle")
		$".".frame = 0

func _on_can_filled_timer_timeout() -> void:
	isFull = true
	$".".play("filled")
