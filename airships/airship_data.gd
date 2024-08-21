class_name AirshipData
extends Resource


@export var items: Array[GameItem]
var items_dict: Dictionary = {}
@export var name: String
@export var forward_speed: GameStat
@export var rotation_speed: GameStat
@export var range_s: GameStat
@export var number_of_bays: GameStat


func get_stats():
	return [forward_speed, rotation_speed, range_s, number_of_bays]


func _to_string():
	return name


func try_get_item_amount(item_type: Global.ItemType):
	if item_type in items_dict:
		return items_dict[item_type].amount
	else:
		return 0


func add_item(item: GameItem, amount: int):
	if item.type in items_dict:
		items_dict[item.type].amount += amount
	else:
		items_dict[item.type] = item.duplicate()
		items_dict[item.type].amount = amount
