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
	width = get_node("SiteDetector/CollisionShape2D").shape.size.x
	game_data = Global.game_data


func drop_active_item():
	if game_data.active_item and game_data.active_item.amount > 0:
		game_data.active_item.amount -= 1
		item_dropped.emit()
		var new_item = game_data.active_item.instantiate()
		get_parent().add_child(new_item)
		new_item.position = position


func _input(event):
	if event.is_action_pressed("action"):
		drop_active_item()
