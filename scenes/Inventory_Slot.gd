extends TextureButton

var item_data = {}  # Initialize item_data as an empty dictionary

func _ready():
	# Ensure item_data is initialized with expected keys
	if not item_data.has("texture"):
		item_data["texture"] = null
	if not item_data.has("item_type"):
		item_data["item_type"] = ""
	if not item_data.has("quantity"):
		item_data["quantity"] = 0

	# If texture_normal is already set, use it to initialize item_data
	if texture_normal:
		item_data["texture"] = texture_normal
		item_data["item_type"] = "example_type"  # Replace with actual item type
		item_data["quantity"] = 1                # Set default quantity

	update_item_texture()
	connect("gui_input", Callable(self, "_on_gui_input"))

# Called when input is detected on the button
func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if item_data["texture"]:
				# Start dragging the item
				var drag_data = {"item": item_data}
				var preview = create_drag_preview()
				set_drag_preview(preview)

# Called to provide the data to be dragged
func get_drag_data(position):
	if item_data and item_data["texture"]:
		var drag_data = {"item": item_data}
		var preview = create_drag_preview()
		set_drag_preview(preview)
		return drag_data
	return null

# Called to create a visual preview for the dragged item
func create_drag_preview():
	var preview = TextureRect.new()
	preview.texture = item_data["texture"]  # Use item_data texture
	preview.size = size
	return preview

# Called to check if the current slot can accept the dropped data
func can_drop_data(position, data):
	return true  # Allow drops in any slot; customize as needed

# Called to handle the dropped data
func drop_data(position, data):
	var dropped_item_data = data["item"]
	if dropped_item_data["texture"] != item_data["texture"]:
		var temp_data = item_data
		item_data = dropped_item_data
		# Find the original slot and swap the data
		for slot in get_parent().get_children():
			if slot != self and slot.item_data == dropped_item_data:
				slot.item_data = temp_data
				slot.update_item_texture()
				break
		update_item_texture()

# Update the slot's appearance based on its item_data
func update_item_texture():
	if item_data["texture"]:
		texture_normal = item_data["texture"]  # Use texture_normal to set the texture
	else:
		texture_normal = null  # Clear the texture if no item
