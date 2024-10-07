class_name DeliveredTriggerEditor
extends TriggerEditor

@onready var places: MultiSelector = %Places
@onready var items: MultiSelector = %Items
@onready var amount: QuantityBox = %Amount


func _init():
	var trigger: DeliveredTrigger


func _ready():
	if trigger:
		for place in trigger.target_place_names:
			places.select(place)
		for item in trigger.target_item_types:
			items.select(item)
		amount.line_edit.text = str(trigger.target_amount)


func _on_place_changed(place: int, checked: bool) -> void:
	if checked and place not in trigger.target_place_names:
		trigger.target_place_names.append(place)
	else:
		trigger.target_place_names.erase(place)


func _on_item_changed(item: int, checked: bool) -> void:
	if checked and item not in trigger.target_item_types:
		trigger.target_item_types.append(item)
	else:
		trigger.target_item_types.erase(item)


func _on_amount_changed(amount: int) -> void:
	trigger.target_amount = amount
