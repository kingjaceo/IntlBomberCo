class_name ResourceDeliveredTrigger
extends Trigger

@export var target_place_names: Array
@export var target_resource_type: Enums.ResourceType
@export var target_amount: float
var current_amount: float
var active = false


func _init():
	trigger_type = Enums.TriggerType.DELIVERED


func activate(ship: Ship, settlement: Settlement):
	var amount_requested = ship.hold.room_for(target_resource_type)
	var amount_taken = settlement.take_resource_from_settlement(target_resource_type, amount_requested)
	ship.hold.add(target_resource_type, amount_taken)


func try_complete(ship: Ship, location: Settlement) -> bool:
	var correct_place = location.place_name in target_place_names
	var correct_resource = ship.hold.has(target_resource_type)
	current_amount = ship.hold.amount(target_resource_type)
	#var correct_amount = current_amount >= target_amount
	if correct_place and correct_resource:
		ship.deliver(target_resource_type, 1000000, location)
		return true
	return false


func destination():
	var choice = randi() % len(target_place_names)
	var place_name = target_place_names[choice]
	return Global.settlements[place_name]

func _get_progress():
	return str(current_amount) + " / " + str(target_amount)
