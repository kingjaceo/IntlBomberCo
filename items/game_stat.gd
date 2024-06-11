class_name GameStat
extends Resource


@export var name: String
@export var amount: float:
	set(value):
		amount = min(capacity, value)
		amount_changed.emit()
@export var capacity: float = INF
@export var cost: float

signal amount_changed
