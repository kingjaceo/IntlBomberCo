class_name Airplane
extends Resource

@export var name: String
@export var forward_speed: GameStat
@export var rotation_speed: GameStat
@export var range_s: GameStat
@export var number_of_bays: GameStat


func get_stats():
	return [forward_speed, rotation_speed, range_s, number_of_bays]


func _to_string():
	return name
