extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if (!itemSlots.is_empty()):
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if(!emptySlots.is_empty()):
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	update.emit()

func remove(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if (!itemSlots.is_empty()):
		itemSlots[0].amount -= 1
		if itemSlots[0].amount == 0:
			var indexToBeRemoved = slots.find(itemSlots[0])
			slots[indexToBeRemoved].item = null
		update.emit()
		
func searchForItem(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if (!itemSlots.is_empty()):
		print("returned amount")
		return itemSlots[0].amount
	else:
		print("returned 0")
		return 0
	
