extends Node

var resource_icons: Dictionary = {
	"food": load("res://game_scenes/world/settlements/food_basket.png"),
	"stone": load("res://game_scenes/world/settlements/stone.png"),
	"bronze": load("res://game_scenes/world/settlements/bronze.png"),
	"population": load("res://game_scenes/world/settlements/pops.png"),
	
}


func get_resource(resource_type: String):
	return resource_icons[resource_type]
