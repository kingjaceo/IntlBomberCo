class_name AirshipData
extends Resource


@export var items: Array[GameItem]
var items_dict: Dictionary = {}
@export var name: String
@export var forward_speed: GameStat
@export var rotation_speed: GameStat
@export var range_s: GameStat
@export var slots: GameStat
@export var world_position: Vector2
@export var rotation: float
var docked: bool = false
var at_site: bool = false

signal item_added


func get_stats():
	return [forward_speed, rotation_speed, range_s, slots]


func _to_string():
	return name


func try_get_item(item_type: Global.ItemType):
	if item_type in items_dict:
		return items_dict[item_type]


func try_get_item_amount(item_type: Global.ItemType):
	if item_type in items_dict:
		return items_dict[item_type].amount
	else:
		return 0


func add_item(item: GameItem, amount: int):
	if item.type in items_dict:
		item = items_dict[item.type]
		item.amount += amount
	else:
		item = item.duplicate()
		item.amount = amount
		items.append(item)
		items_dict[item.type] = item
	item_added.emit(item)
