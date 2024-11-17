extends Node


var AllEnumsDict: Dictionary = {
	AllEnums.PLACE_NAME: Enums.PlaceName, 
	AllEnums.ITEM_TYPE: Enums.ItemType, 
	AllEnums.BUILDING_TYPE: Enums.BuildingType, 
	}
enum AllEnums {PLACE_NAME, ITEM_TYPE, BUILDING_TYPE}
enum PlaceName {DARESH, VITOK, SABREK}
enum ItemType {AID, BOMB, DRONE, OTHER}
enum BuildingType {RESIDENTIAL, COMMERCIAL, INDUSTRIAL, MILITARY}
enum RewardType {NONE, REPUTATION, VICTORY}
enum TriggerType {NONE, DELIVERED}
enum ReputationType {HELP, HURT}
enum SettlementFeature {SPRING, STONE, ORE}

enum ResourceType {POPULATION, STONE, FOOD, BRONZE}
var ResourceWeights = {
	ResourceType.POPULATION: 0,
	ResourceType.STONE: 1,
	ResourceType.FOOD: 5,
	ResourceType.BRONZE: 3
}
var Colors = [
	Color.FIREBRICK,
	Color.GOLDENROD,
	Color.CORAL,
	Color.SEA_GREEN
]
var buildings = [
	load("res://game_scenes/world/settlements/buildings/apartment.tres"),
	load("res://game_scenes/world/settlements/buildings/quarry.tres"),
	load("res://game_scenes/world/settlements/buildings/bronze_manufactory.tres"),
	load("res://game_scenes/world/settlements/buildings/orchard.tres"),
]
