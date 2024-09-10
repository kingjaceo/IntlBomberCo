class_name ObjectiveGrid
extends Resource


@export var rows: int = 1
@export var columns: int = 1
@export var grid: Dictionary # {Vector2i: Objective}
@export var rightlinks: Dictionary # {Vector2i: ObjectiveGridLink}
@export var downlinks: Dictionary # {Vector2i: ObjectiveGridLink}


func add_objective(location: Vector2i, objective: Objective):
	if location.x >= columns:
		columns = location.x + 1
	if location.y >= rows:
		rows = location.y + 1
	grid[location] = objective

func get_objective(location: Vector2i):
	return grid.get(location)

func remove_objective(location: Vector2i):
	grid.erase(location)


func add_rightlink(location: Vector2i, link: ObjectiveGridLink):
	rightlinks[location] = link

func get_rightlink(location: Vector2i) -> ObjectiveGridLink:
	return rightlinks.get(location)

func remove_rightlink(location: Vector2i):
	rightlinks.erase(location)


func add_downlink(location: Vector2i, link: ObjectiveGridLink):
	downlinks[location] = link

func get_downlink(location: Vector2i) -> ObjectiveGridLink:
	return downlinks.get(location)

func remove_downlink(location: Vector2i):
	downlinks.erase(location)


func frontier() -> Array[Objective]:
	return [grid[Vector2i.ZERO]]
