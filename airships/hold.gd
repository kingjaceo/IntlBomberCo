class_name Hold
extends Resource
# represents the Hold of a ship

var hold: Dictionary = {} # {resource_type: amount}
var hold_slots: int = 2 # >= len(hold)
var slot_capacity: int = 10 # >= hold[resource_type]


func has(key: Variant) -> bool:
	return hold.has(key)


func get_amount(key: Variant) -> int:
	return hold.get(key, 0)


func amount(key: Variant) -> int:
	return hold.get(key, 0)


func add(key: Variant, amount: int) -> int:
	var amount_added: int = 0
	var max_to_add  = slot_capacity - hold.get(key, 0)
	amount_added = min(amount, max_to_add)
	if key in hold:
		hold[key] += amount_added
	elif len(hold) < hold_slots:
		hold[key] = amount_added
	return amount_added


func remove(key: Variant, amount: int) -> int:
	var amount_removed: int = min(amount, hold.get(key, 0))
	if hold.has(key):
		hold[key] -= amount_removed
	return amount_removed
