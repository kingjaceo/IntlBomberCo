class_name Player
extends Node2D

var game_data: GameData
@export var current_airship: AirshipData
var width: float

signal item_dropped


func _ready():
	if current_airship:
		Global.player_airship_data = current_airship
	elif Global.player_airship_data:
		current_airship = Global.player_airship_data
	else:
		push_error("No AirshipData detected for player!")
	position  = current_airship.world_position
	rotation = current_airship.rotation
	game_data = Global.game_data
