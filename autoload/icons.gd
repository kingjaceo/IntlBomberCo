extends Node

var resource_icons: Dictionary = {
	Enums.ResourceType.FOOD: load("res://game_scenes/world/settlements/food_basket.png"),
	Enums.ResourceType.STONE: load("res://game_scenes/world/settlements/stone.png"),
	Enums.ResourceType.BRONZE: load("res://game_scenes/world/settlements/bronze.png"),
	Enums.ResourceType.POPULATION: load("res://game_scenes/world/settlements/pops.png"),
	
}


func get_resource(resource_type: Enums.ResourceType):
	return resource_icons[resource_type]
