class_name ItemStat
extends Resource

@export var name: String
@export var value: float:
	set(new_value):
		value = new_value
		value_changed.emit()
@export var max_value: float
@export var step_size: float
@export var step_cost: float

signal value_changed
