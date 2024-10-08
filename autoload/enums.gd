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

enum ResourceType {POPULATION, STONE, FOOD, BRONZE}
var resource_types: Array[String] = ["population", "stone", "food", "bronze"]
var empty_resources_dict: Dictionary = {
	"population": 0,
	"stone": 0,
	"food": 0,
	"bronze": 0,
}
