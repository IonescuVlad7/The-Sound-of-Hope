extends Panel

@onready var itemVisual: Sprite2D = $CenterContainer/Panel/itemDisplay

@onready var amount_text: Label = $CenterContainer/Panel/Label	

func update(slot: InvSlot):
	if slot.item:  # Check if slot.item exists
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		amount_text.visible = slot.amount > 1
		amount_text.text = str(slot.amount)
	else:
		itemVisual.visible = false
		amount_text.visible = false
	
