class_name City
extends Node2D

@export var x_blocks: int = 20
@export var y_blocks: int = 10
@export var road_width: int = 50
@export var building: PackedScene
var game_data: Resource
var width: float = 0
var height: float = 0


func _ready():
	game_data = Global.game_data
	var x_start: int = road_width
	var y_start: int = road_width
	var block_width: int = 0
	for i in x_blocks:
		for j in y_blocks:
			var block = building.instantiate()
			add_child(block)
			block.position = Vector2(x_start, y_start)
			block_width = block.width
			y_start += block_width + road_width
		x_start += block_width + road_width
		height = y_start
		y_start = road_width
	width = x_start
