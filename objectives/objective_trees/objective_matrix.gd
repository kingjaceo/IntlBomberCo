class_name ObjectiveGrid
extends Resource


@export var rows: int = 1
@export var columns: int = 1
@export var grid: Dictionary = {}# {Vector2i: Objective}


func _init():
	if len(grid) == 0:
		grid[Vector2i.ZERO] = Objective.new()
		rows = 1
		columns = 1


func add_objective(location: Vector2i, objective: Objective):
	if location.x >= columns:
		columns = location.x + 1
	if location.y >= rows:
		rows = location.y + 1
	grid[location] = objective
