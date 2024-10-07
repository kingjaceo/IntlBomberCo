class_name DeliverButton
extends Button

var items: Array[GameItem]
@onready var dock_storage = %DockStorage


func _ready():
	for child in dock_storage.get_children():
		child.item_added.connect(_item_added)
		child.item_removed.connect(_item_removed)

	disabled = true
	pressed.connect(_on_pressed)


func _item_added(item: GameItem):
	# check item against contracts
	for contract in Global.player_game_data.contracts:
		if contract.trigger is DeliveredTrigger and item.type in contract.trigger.target_item_types and contract.trigger.active:
			disabled = false
		items.append(item)


func _item_removed(item: GameItem):
	items.erase(item)
	_update_disabled()


func _on_pressed():
	for item in items:
		for contract in Global.player_game_data.contracts:
			if contract.trigger is DeliveredTrigger:
				contract.trigger.try_deliver_item(item) 
				_update_disabled()


func _update_disabled():
	disabled = true
	for i in items:
		for contract in Global.player_game_data.contracts:
			if contract.trigger is DeliveredTrigger and i.type in contract.trigger.target_item_types and contract.trigger.active:
				disabled = false
