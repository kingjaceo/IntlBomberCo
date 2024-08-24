class_name DeliveredTrigger
extends Trigger

@export var target_place_names: Array[Global.PlaceName]
@export var target_item_types: Array[Global.ItemType]
@export var target_amount: float
var current_amount: float
var active = false


func activate():
	current_amount = 0
	active = true


func try_deliver_item(item: GameItem):
	var correct_place = true
	if len(target_place_names) > 0:
		correct_place = Global.current_settlement_data.settlement_name in target_place_names
	var correct_item = true
	if len(target_item_types) > 0:
		correct_item = item.type in target_item_types
	if correct_place and correct_item:
		_deliver_item(item)


func _deliver_item(item: GameItem):
	if active:
		var amount_to_take = min(item.amount, target_amount - current_amount)
		current_amount += amount_to_take
		item.amount -= current_amount
		progress_changed.emit()
		if current_amount >= target_amount:
			triggered.emit()
			active = false


func _get_progress():
	return str(current_amount) + " / " + str(target_amount)
