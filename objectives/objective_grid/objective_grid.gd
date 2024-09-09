class_name ObjectiveGrid
extends Resource


@export var rows: int = 1
@export var columns: int = 1
@export var grid: Dictionary # {Vector2i: Objective}
@export var right_adjacency: Dictionary # {Vector2i: bool}
@export var down_adjacency: Dictionary # {Vector2i: bool}


#func _init():
	#if len(grid) == 0:
		#grid[Vector2i.ZERO] = Objective.new()
		#rows = 1
		#columns = 1
	#else: # set the rows and columns correctly
		#pass


func add_objective(location: Vector2i, objective: Objective):
	if location.x >= columns:
		columns = location.x + 1
	if location.y >= rows:
		rows = location.y + 1
	grid[location] = objective


func get_right_adjacency(location: Vector2i) -> bool:
	if right_adjacency.get(location):
		return true
	return false

func get_down_adjacency(location: Vector2i) -> bool:
	if down_adjacency.get(location):
		return true
	return false
