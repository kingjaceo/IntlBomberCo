class_name Hold
extends Resource
# represents the Hold of a ship

var hold: Dictionary = {} # {resource_type: amount}
@export var hold_slots: int = 2 # >= len(hold)
@export var slot_capacity: int = 30 # >= hold[resource_type]

signal hold_changed


func has(key: Variant) -> bool:
	return hold.has(key)


func amount(key: Variant) -> int:
	return hold.get(key, 0)


func add(key: Variant, _amount: int) -> int:
	var amount_added: int = 0
	var max_to_add  = slot_capacity - hold.get(key, 0)
	amount_added = min(_amount, max_to_add)
	if key in hold:
		hold[key] += amount_added
	elif len(hold) < hold_slots:
		hold[key] = amount_added
	hold_changed.emit()
	return amount_added


func remove(key: Variant, _amount: int) -> int:
	var amount_removed: int = min(_amount, hold.get(key, 0))
	if hold.has(key):
		hold[key] -= amount_removed
		if hold[key] <= 0:
			hold.erase(key)
	hold_changed.emit()
	return amount_removed


func room_for(key: Variant) -> int:
	if hold.has(key) and hold.get(key) < slot_capacity:
		return slot_capacity - hold.get(key)
	elif len(hold) < hold_slots:
		return slot_capacity
	return 0
