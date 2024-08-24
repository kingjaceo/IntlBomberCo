class_name InventoryDisplay
extends BoxContainer

var current_airship: AirshipData
var slot_scene: PackedScene = load("res://inventory/item_slot.tscn")
var icon_scene: PackedScene = load("res://inventory/item_icon.tscn")
var items_to_icons: Dictionary # {GameItem: GameIcon}
var active_item_icon: ItemIcon


func _ready():
	current_airship = Global.player_airship_data
	current_airship.item_added.connect(_add_item)
	_load_items()


func _load_items():
	for child in get_children():
		child.free()
	for slot in range(current_airship.slots.value):
		var instance = slot_scene.instantiate()			
		add_child(instance)
	for item in current_airship.items:
		_create_add_icon(item)


func _add_item(item: GameItem):
	if item not in items_to_icons:
		_create_add_icon(item)


func _create_add_icon(item: GameItem):
	for slot in get_children():
		if not slot.icon:
			var icon_instance = icon_scene.instantiate()
			icon_instance.item = item
			icon_instance.texture = item.icon
			items_to_icons[item] = icon_instance
			slot.icon = icon_instance
			slot.add_child(icon_instance)
			return	


func _update_active_item_icon(active_item: GameItem):
	for slot in get_children():
		Global.stop_highlight(slot)
		if slot.icon and active_item == slot.icon.item:
			Global.highlight(slot)
