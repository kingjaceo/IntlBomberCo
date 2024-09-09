class_name ObjectiveGridEditor
extends GridContainer

var objective_grid: ObjectiveGrid
var objective_editor_scene: PackedScene = load("res://objectives/objective_grid/objective_editor/objective_editor.tscn")
var objective_link_scene: PackedScene = load("res://objectives/objective_grid/objective_link/objective_link_editor.tscn")
var objective_grid_copy: ObjectiveGrid


func _ready() -> void:
	for child in get_children():
		child.free()
	if objective_grid:
		objective_grid_copy = objective_grid.duplicate()
		_populate()


func set_objective_grid(new_grid: ObjectiveGrid):
	objective_grid = new_grid
	_ready()


func _populate():
	columns = objective_grid_copy.columns * 2
	for r in range(objective_grid_copy.rows):
		_pad(2*r)
		#_pad(2*r+1)
		for c in range(objective_grid_copy.columns):
			var location = Vector2i(c, r)
			var child_index = _get_child_index(location)
			var objective = objective_grid_copy.grid.get(location)
			if objective:
				_create_editor(child_index, objective)
				#var right_location = location + Vector2i(1, 0)
				#var rightlink_active = location + Vector2i(1, 0) in objective_grid_copy.adjacency[location]
				_create_rightlink(child_index + 1, objective_grid_copy.get_right_adjacency(location))
				_create_downlink(child_index + columns, objective_grid_copy.get_down_adjacency(location))


func _create_editor(index: int, objective: Objective):
	get_child(index).free() # we can assume there is a dummy here
	var new_editor = objective_editor_scene.instantiate()
	new_editor.objective = objective
	var location = _get_index_location(index)
	objective_grid_copy.add_objective(location, objective)
	add_child(new_editor)
	move_child(new_editor, index)


func _create_rightlink(index: int, active: bool = false):
	get_child(index).free() # we can assume there is a dummy here
	var objective_link = objective_link_scene.instantiate()
	var location = _get_index_location(index)
	objective_link.add_link_pressed.connect(_right_link_pressed.bind(location))
	#objective_link.text = "R" + str(_get_index_location(index))
	objective_link.active = active
	add_child(objective_link)
	move_child(objective_link, index)


func _create_downlink(index: int, active: bool = false):
	get_child(index).free() # we can assume there is a dummy here
	var objective_link = objective_link_scene.instantiate()
	var location = _get_index_location(index)
	objective_link.add_link_pressed.connect(_down_link_pressed.bind(location))
	#objective_link.text = "D" + str(_get_index_location(index))
	objective_link.active = active
	add_child(objective_link)
	move_child(objective_link, index)


func _pad(row: int, from: int = 0, to: int = columns):
	var child_index = _get_child_index(Vector2i(0, row))# columns * row + x
	var num_children = len(get_children())
	for x in range(from, to): # pads interval with dummies
		var c1 = Control.new()
		add_child(c1)
		if child_index < num_children:
			move_child(c1, child_index)
		child_index += 1
		var c2 = Control.new()
		add_child(c2)
		if child_index < num_children:
			move_child(c2, child_index)
		child_index += columns + 1


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
	var column = location.x * 2
	if column >= columns:
		_vpad(column)
		columns += 2
	var index = _get_child_index(location)
	if location not in objective_grid.grid:
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
	ResourceSaver.save(objective_grid_copy, objective_grid.resource_path)
