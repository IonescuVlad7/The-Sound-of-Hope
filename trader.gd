extends StaticBody2D

@warning_ignore("shadowed_global_identifier")
@export var seed: InvItem #seed
@export var wood: InvItem #wood
@export var carrot: InvItem #carrot
@export var knife: InvItem #carrot

@onready var interactionArea = $InteractionArea

var questDone = false
var seedsNotGiven = true

const linesStart: Array[String] = [
	"Hello there, stranger!",
	"I haven`t seen you before, so you must be new around here...",
	"Wanna help me out?",
	"I only need 30 carrots and 30 wood to finish building my super secret hideout",
	"I will give you my fire dagger if you help me out",
	"You are not the talkative type, huh?",
	"You can gather wood from trees around here. Press R to cut them down.",
	"Also, I can extract two seeds from one carrot, so come to me when you are out",
	"Here are some seeds to start with",
	"See you soon, stranger!"
]
const linesCommon: Array[String] = [
	"Hello, stranger! Have you brought me some carrots to extract seeds?"
]
const linesCommonNoCarrots: Array[String] = [
	"You seem to be out of carrots, but it`s a pleasure to see you around.",
	"Come by anytime <3"
]
const linesQuestDone: Array[String] = [
	"Thank you so much, stranger. I can finally finish that human trap. I mean super secret hideout",
	"Here`s your fire knife. Now go away. I need some alone time."
]
const linesQuestFinished: Array[String] = [
	"I have so much work to do...",
]
var dialogTimes = 0

func _ready() -> void:
	InteractionManager.base_text = "[E] to "
	interactionArea.interact = Callable(self,"start_dialog")
	$AnimatedSprite2D.play("idle2")

func start_dialog():
	if questDone: # if quest is done, says same line
		DialogManager.start_dialog(global_position, linesQuestFinished)
		return
	var player = get_tree().get_first_node_in_group("player")
	var carrots = player.searchForItem(carrot)
	var woodPieces = player.searchForItem(wood)
	if carrots == 30 && woodPieces == 30:
		DialogManager.start_dialog(global_position, linesQuestDone)
		questDone = true
		while carrots > 0:
			player.remove(carrot)
			player.remove(wood)
			carrots -= 1
		player.collect(knife)
		return
	# check if the needed quest items are in inventory
	#if that's the case, call chat 3
	dialogTimes += 1
	print(dialogTimes)
	if dialogTimes < 10 && DialogMap2.firstDialog:
		#first time talking
		DialogManager.start_dialog(global_position, linesStart)
		DialogMap2.firstDialog = false
		if seedsNotGiven:
			player.collect(seed)
			player.collect(seed)
			player.collect(seed)
			player.collect(seed)
			seedsNotGiven = false
	else:
		#1: #talking until quest is done
		dialogTimes = 10
		DialogManager.start_dialog(global_position, linesCommon)
		
		# check if there are carrots in inventory
		#daca da, sterge nr din inv si adauga dublu seeds
		if carrots > 0  && carrots < 30:
			while carrots > 0:
				player.collect(seed)
				player.collect(seed)
				player.remove(carrot)
				carrots -= 1
			return
		DialogManager.start_dialog(global_position, linesCommonNoCarrots)
	
