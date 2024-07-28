class_name GameItem
extends Resource

@export var name: String
@export var amount: float:
	set(value):
		amount = min(capacity, value)
		amount_changed.emit()
@export var capacity: float = INF
@export var cost: float
@export var item_scene: PackedScene
@export var item_stats: Array[GameStat]
@export var item_type: Global.ItemType

signal amount_changed


func instantiate():
	return item_scene.instantiate()
