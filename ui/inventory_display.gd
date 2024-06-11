class_name InventoryDisplay
extends Control

@export var inventory_button: PackedScene
var game_data: GameData
var active_button: InventoryButton
var buttons: Array[InventoryButton]
var buttons_to_items: Dictionary # {InventoryButton: GameItem}


func _ready():
	game_data = Global.game_data
	buttons_to_items = {}
	for item in game_data.items:
		var button = inventory_button.instantiate()
		button.item = item
		button.pressed.connect(_update_active_button.bind(button))
		buttons.append(button)
		buttons_to_items[button] = item
		add_child(button)
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
