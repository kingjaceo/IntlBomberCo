extends Node

var game_data: GameData = load("res://game_data/tutorial_game_data.tres")
var player_game_data: GameData = load("res://game_data/player_game_data.tres")
var player_airship_data: AirshipData
var current_settlement_data: SettlementData
enum PlaceName {DARESH, VITOK, SABREK}
enum ItemType {AID, BOMB, DRONE, OTHER}
enum BuildingType {RESIDENTIAL = 1, COMMERCIAL = 2, INDUSTRIAL = 4, MILITARY = 8}
