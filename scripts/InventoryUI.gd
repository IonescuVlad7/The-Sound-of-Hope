extends Control

var selected_slot = -1
var inventory_visible = false  # Keeps track of inventory visibility

func _ready():
	for i in range(3):
		var slot = $TextureRect/PanelContainer/GridContainer.get_child(i)
		slot.get_node("Label").text = str(i + 1)
	hide()  # Start with the inventory hidden
	inventory_visible = false
	set_process_input(true)  # Enable input processing for this node

func _input(event):
	#if event is InputEventKey and event.pressed and event.keycode == KEY_TAB:
		#toggle_inventory()
	if event.is_action_pressed("ui_select_1"):
		select_slot(0)
	elif event.is_action_pressed("ui_select_2"):
		select_slot(1)
	elif event.is_action_pressed("ui_select_3"):
		select_slot(2)

func select_slot(index):
	selected_slot = index
	# Logic for selecting and highlighting the hotbar slot
	print("Selected slot:", selected_slot)

func _drop_data(position, data):
	# Handle dragging and dropping within the inventory
	var slot = find_slot_at_position(position)
	if slot:
		slot.set_drag_data(data)
		
func find_slot_at_position(position):
	for slot in $TextureRect/PanelContainer/GridContainer.get_children():
		var slot_global_rect = slot.get_global_rect()
		if slot_global_rect.has_point(position):
			return slot
	return null

func _on_texture_button_gui_input(event):
	pass # Replace with function body.

#func toggle_inventory():
	#if inventory_visible:
		#hide()
		#inventory_visible = false
	#else:
		#show()
		#inventory_visible = true
