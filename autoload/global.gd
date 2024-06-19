extends Node

const building_types = ["Residential", "Commercial", "Industrial"]
enum BuildingTypes {RESIDENTIAL, COMMERCIAL, INDUSTRIAL}
var game_data: GameData = load("res://game_data/tutorial_game_data.tres")
var player_game_data: GameData = load("res://game_data/player_game_data.tres")
