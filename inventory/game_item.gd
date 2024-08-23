class_name GameItem
extends Resource

@export var name: String
@export var type: Global.ItemType
@export var amount: float:
	set(value):
		amount = min(capacity, value)
		amount_changed.emit()
@export var capacity: float = INF
@export var cost: float
@export var scene: PackedScene
@export var icon: Texture
@export var item_stats: Array[GameStat]

signal amount_changed


func instantiate():
	return scene.instantiate()
