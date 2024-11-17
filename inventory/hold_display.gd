class_name HoldDisplay
extends BoxContainer

var hold: Hold
var slot_scene: PackedScene = load("res://inventory/item_slot.tscn")
var icon_scene: PackedScene = load("res://inventory/item_icon.tscn")
var items_to_icons: Dictionary # {GameItem: GameIcon}
var active_item_icon: ItemIcon


func _ready():
	hold = owner.hold
	hold.hold_changed.connect(_update)
	_initialize_slots()
	_update()


func _initialize_slots():
	for child in get_children():
		child.free()
	for slot in range(hold.hold_slots):
		var instance = slot_scene.instantiate()
		add_child(instance)


func _update():
	var slot_index = 0
	var resources = hold.hold.keys()
	var amounts = hold.hold.values()
	for i in range(hold.hold_slots):
		var slot: ItemSlot = get_child(i)
		if len(resources) > i:
			slot.amount = amounts[i]
			slot.set_icon(Icons.get_resource(resources[i]))
		else:
			slot.clear()


#func _create_add_icon(item: GameItem):
	#for slot in get_children():
		#if not slot.icon:
			#var icon_instance = icon_scene.instantiate()
			#icon_instance.item = item
			#icon_instance.texture = item.icon
			#items_to_icons[item] = icon_instance
			#slot.icon = icon_instance
			#slot.add_child(icon_instance)
			#return	


func _update_active_item_icon(active_item: GameItem):
	for slot in get_children():
		Global.stop_highlight(slot)
		if slot.icon and active_item == slot.icon.item:
			Global.highlight(slot)
