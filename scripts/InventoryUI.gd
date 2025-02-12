# InventoryUI.gd
extends Control

@onready var grid_container = $GridContainer
@onready var inventory = get_node("..")

func _ready():
	update_inventory_ui()
	hide()  # Initially hide the inventory

# Update the inventory UI
func update_inventory_ui():
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.queue_free()
	
	# Add buttons for each item in the inventory
	#for item in inventory.items.values():
		#var button = TextureButton.new()
		#button.texture_normal = load("res://test.jpg")  # Load the item texture
		#button.set_meta("item_id", item.id)  # Store item ID in the button's metadata
		#button.connect("pressed", Callable(self, "_on_item_button_pressed"))
		#grid_container.add_child(button)

# Handle item button pressed
#func _on_item_button_pressed():
	#var button = get_focus_owner()  # Get the button that triggered the event
	#var item_id = button.get_meta("item_id")  # Retrieve the item ID from the button's metadata
	#print("Item ID:", item_id)
	## Handle item usage or other actions here
	
func toggle_inventory():
	if is_visible():
		print("Inventory is visible, hiding...")
		hide()
	else:
		print("Inventory is hidden, showing...")
		show()
