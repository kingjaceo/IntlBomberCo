class_name ObjectiveGridEditor
extends GridContainer

@export var objective_grid: ObjectiveGrid
@export var objective: Objective
var objective_editor_scene: PackedScene = load("res://objectives/objective_trees/objective_editor.tscn")
var objective_link_scene: PackedScene = load("res://objectives/objective_trees/objective_tree_gate.tscn")
var objective_grid_copy: ObjectiveGrid


func _ready() -> void:
	for child in get_children():
		child.free()
	if not objective_grid:
		objective_grid = ObjectiveGrid.new()
	objective_grid_copy = objective_grid.duplicate()
	_populate()


func _populate():
	columns = objective_grid_copy.columns * 2
	for r in range(objective_grid_copy.rows):
		_pad(r)
		_pad(r+1)
		for c in range(objective_grid_copy.columns):
			var location = Vector2i(c, r)
			var child_index = _get_child_index(location)
			var objective = objective_grid_copy.grid.get(location)
			if objective:
				_create_editor(child_index, objective)
				_create_rightlink(child_index + 1)
				_create_downlink(child_index + columns)


func _create_editor(index: int, objective: Objective):
	get_child(index).free() # we can assume there is a dummy here
	var new_editor = objective_editor_scene.instantiate()
	new_editor.objective = objective
	var location = _get_index_location(index)
	objective_grid_copy.add_objective(location, objective)
	add_child(new_editor)
	move_child(new_editor, index)


func _create_rightlink(index: int):
	get_child(index).free() # we can assume there is a dummy here
	var objective_link = objective_link_scene.instantiate()
	var location = _get_index_location(index)
	objective_link.pressed.connect(_right_link_pressed.bind(location))
	objective_link.text = "R" + str(_get_index_location(index))
	add_child(objective_link)
	move_child(objective_link, index)


func _create_downlink(index: int):
	get_child(index).free() # we can assume there is a dummy here
	var objective_link = objective_link_scene.instantiate()
	var location = _get_index_location(index)
	objective_link.pressed.connect(_down_link_pressed.bind(location))
	objective_link.text = "D" + str(_get_index_location(index))
	add_child(objective_link)
	move_child(objective_link, index)


func _pad(row: int, from: int = 0, to: int = columns):
	var child_index = _get_child_index(Vector2i(0, row))# columns * row + x
	for x in range(from, to): # pads interval with dummies
		var c1 = Control.new()
		add_child(c1)
		move_child(c1, child_index)
		child_index += 1


func _vpad(column: int):
	var num_children = len(get_children())
	var location = Vector2i(int(column / 2), 0)
	var child_index = _get_child_index(location)
	for x in range(0, num_children / columns):
		var c1 = Control.new()
		add_child(c1)
		move_child(c1, child_index)
		child_index += 1
		var c2 = Control.new()
		add_child(c2)
		move_child(c2, child_index)
		child_index += columns + 1


func _right_link_pressed(location: Vector2i):
	location.x += 1
	#var index = _get_child_index(location)
	var column = location.x * 2
	if column >= columns:
		_vpad(column)
		#_vpad(column + 1)
		columns += 2
		#column = _get_column(index)
	var index = _get_child_index(location)
	_create_editor(index, Objective.new())
	_create_rightlink(index + 1)
	_create_downlink(index + columns)


func _down_link_pressed(location: Vector2i):
	location.y += 1
	var index = _get_child_index(location)
	var rows = len(get_children()) / columns
	var row = _get_row(index)
	if row >= rows:
		_pad(row)
		_pad(row + 1)
		rows += 2
	_create_editor(index, Objective.new())
	_create_rightlink(index + 1)
	_create_downlink(index + columns)


func _get_child_index(location: Vector2i) -> int:
	return location.x * 2 + location.y * 2 * columns


func _get_index_location(index: int) -> Vector2i:
	var y = int(_get_row(index) / 2)
	var x = int(_get_column(index) / 2)
	return Vector2i(x, y)


func _get_row(index: int) -> int:
	return int(index / columns)


func _get_column(index: int) -> int:
	return int(index % columns)


func _save():
	ResourceSaver.save(objective_grid_copy, "test_objective_grid.tres")
