extends TextureRect

var dragging = false
var drag_offset = Vector2()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Check if the mouse is in the top part of the TextureRect (e.g., top 20% of its height)
			var mouse_pos = get_local_mouse_position()
			if mouse_pos.y < size.y * 0.25:  # Adjust the 0.2 as needed
				dragging = true
				drag_offset = mouse_pos
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = false

func _process(delta):
	if dragging:
		var mouse_pos_global = get_global_mouse_position()
		position = mouse_pos_global - drag_offset
