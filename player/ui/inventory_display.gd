class_name InventoryDisplay
extends Control

var game_data: GameData
var active_button: InventoryButton
var buttons: Array[InventoryButton]
var buttons_to_items: Dictionary # {InventoryButton: GameItem}

var items: Array[GameItem]
var inventory_button: PackedScene = load("res://player/ui/inventory_button.tscn")

func _ready():
	if owner.current_airship:
		items = owner.current_airship.items	
		buttons_to_items = {}
		for child in get_children():
			child.queue_free()
		for item in items:
			var button = inventory_button.instantiate()
			button.item = item
			button.pressed.connect(_update_active_button.bind(button))
			buttons.append(button)
			buttons_to_items[button] = item
			add_child(button)
		if len(buttons) > 0:
			_update_active_button(buttons[0])



func _input(event):
	if event.is_action_pressed("1"):
		_update_active_button(buttons[0])
	if event.is_action_pressed("2"):
		_update_active_button(buttons[1])
	if event.is_action_pressed("3"):
		_update_active_button(buttons[2])


func _update_active_button(button):
	if button != active_button:
		active_button = button
		for b in buttons:
			b.active_button = false
			b.modulate = Color.WHITE
			b.self_modulate = Color.WHITE
		active_button.active_button = true
		active_button.self_modulate = Color.DARK_BLUE
		game_data.active_item = buttons_to_items[button]