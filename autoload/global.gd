extends Node

const building_types = ["Residential", "Commercial", "Industrial"]
enum BuildingTypes {RESIDENTIAL, COMMERCIAL, INDUSTRIAL}
var game_data: GameData = load("res://game_data/tutorial_game_data.tres")
var player_game_data: GameData = load("res://game_data/player_game_data.tres")
var current_scene: PackedScene = load("res://scenes/start_menu.tscn")
var current_scene_instance: Node2D

enum ItemType {AID, BOMB, DRONE, OTHER}
enum BuildingType {RESIDENTIAL = 1, COMMERCIAL = 2, INDUSTRIAL = 4, MILITARY = 8}


func _ready():
	transition_to(current_scene)


func transition_to(scene: PackedScene):
	await get_tree().process_frame
	Utility.save_game_data("player_save.res")
	
	get_tree().paused = false
	
	get_tree().change_scene_to_packed(scene)
	current_scene = scene

