class_name GameData
extends Resource


@export var current_plane: Airplane
@export var items: Array[GameItem]
@export var planes: Array[Airplane]
@export var money: int = 10000:
	set(value):
		money = value
		money_changed.emit()
var buildings_destroyed: int = 0
var active_item: GameItem
var tutorial_active: bool = true

signal money_changed


func on_building_destroyed():
	money += 1000
	buildings_destroyed += 1
