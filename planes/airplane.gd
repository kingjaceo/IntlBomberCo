class_name Airplane
extends Resource

@export var name: String
@export var forward_speed: GameStat
@export var rotation_speed: GameStat
@export var range_s: GameStat
@export var number_of_bays: GameStat


func _to_string():
	return name
