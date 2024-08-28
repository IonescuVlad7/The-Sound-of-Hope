# Inventory.gd
extends Node

class_name Inventory

# Define a simple item class
class Item:
	var id: int
	var name: String
	var quantity: int

# The player's inventory as a dictionary
var items = {}

# Add an item to the inventory
func add_item(item_id: int, item_name: String, quantity: int):
	if item_id in items:
		items[item_id].quantity += quantity
	else:
		var item = Item.new()
		item.id = item_id
		item.name = item_name
		item.quantity = quantity
		items[item_id] = item

# Remove an item from the inventory
func remove_item(item_id: int, quantity: int):
	if item_id in items:
		items[item_id].quantity -= quantity
		if items[item_id].quantity <= 0:
			items.erase(item_id)

# Get the quantity of an item in the inventory
func get_item_quantity(item_id: int) -> int:
	if item_id in items:
		return items[item_id].quantity
	return 0
