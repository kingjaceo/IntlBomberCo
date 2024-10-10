class_name ResourcesDisplay
extends Control

var resource_display: PackedScene = load("res://game_scenes/world/settlements/resource_display.tscn")
var resources: Resources
#var icons: Dictionary = {
	#Enums.ResourceType.FOOD: load("res://game_scenes/world/settlements/food_basket.png"),
	#Enums.ResourceType.STONE: load("res://game_scenes/world/settlements/stone.png"),
	#Enums.ResourceType.BRONZE: load("res://game_scenes/world/settlements/bronze.png"),
	#Enums.ResourceType.POPULATION: load("res://game_scenes/world/settlements/pops.png")
#}


func _ready():
	for child in get_children():
		child.queue_free()
	await owner.tree_entered
	for resource_type in Enums.ResourceType.values():
		var c = resource_display.instantiate()
		c.resources = resources
		c.resource_type = resource_type
		c.icon = Icons.get_resource(resource_type)
		add_child(c)
