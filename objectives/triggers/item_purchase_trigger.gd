class_name ItemPurchaseTrigger
extends Trigger

@export var target_amount: int
@export var target_type: Enums.ItemType
var current_amount = 0


func activate(ship: Ship, location: Settlement):
	Events.item_purchased.connect(_on_item_purchased)


func _on_item_purchased(item_type: Enums.ItemType):
	if item_type == target_type:
		current_amount += 1
		if current_amount >= target_amount:
			triggered.emit()


func _get_progress() -> String:
	return str(round(current_amount / target_amount * 100)) + "%"
