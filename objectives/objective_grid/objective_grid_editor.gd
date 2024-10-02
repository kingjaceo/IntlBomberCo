class_name ObjectiveGridEditor
extends GridContainer

var last_objective_grid: ObjectiveGrid
var objective_editor_scene: PackedScene = load("res://objectives/objective_grid/objective_editor/objective_editor.tscn")
var objective_link_scene: PackedScene = load("res://objectives/objective_grid/objective_link/objective_link_editor.tscn")
var objective_grid: ObjectiveGrid


func _ready() -> void:
	for child in get_children():
		child.free()
	if last_objective_grid:
		objective_grid = last_objective_grid.duplicate()
		_populate()


func set_objective_grid(new_grid: ObjectiveGrid): 
	last_objective_grid = new_grid
	_ready()


func _populate():
	columns = objective_grid.columns * 2
	for r in range(objective_grid.rows):
		_pad(2*r)
		for c in range(objective_grid.columns):
			var location = Vector2i(c, r)
			var child_index = _get_child_index(location)
			var objective = objective_grid.grid.get(location)
			if objective:
				_create_editor(child_index, objective)
				_create_rightlink(child_index + 1)
				_create_downlink(child_index + columns)


func _fill_cell(location: Vector2i):
	var index = _get_child_index(location)
	if location not in objective_grid.grid:
		objective_grid.add_objective(location, Objective.new())
		_create_editor(index, objective_grid.get_objective(location))
	if location not in objective_grid.rightlinks:
		_create_rightlink(index + 1)
	if location not in objective_grid.downlinks:
		_create_downlink(index + columns)


func _create_editor(index: int, objective: Objective):
	get_child(index).free() # we can assume there is a dummy here
	var new_editor = objective_editor_scene.instantiate()
	new_editor.objective = objective
	var location = _get_index_location(index)
	new_editor.removed.connect(objective_grid.remove_objective.bind(location))
	new_editor.removed.connect(_make_placeholder_cell.call_deferred.bind(index))
	objective_grid.add_objective(location, objective)
	add_child(new_editor)
	move_child(new_editor, index)


func _create_rightlink(index: int):
	get_child(index).free() # we can assume there is a dummy here
	var objective_link_editor = objective_link_scene.instantiate()
	var location = _get_index_location(index)
	objective_link_editor.objective_link = objective_grid.get_rightlink(location)
	objective_link_editor.add_link_pressed.connect(_right_link_pressed.bind(location))
	objective_link_editor.orientation = ObjectiveLinkEditor.Orientation.RIGHT
	objective_link_editor.removed.connect(objective_grid.remove_rightlink.bind(location))
	#objective_link_editor.removed.connect(_create_rightlink.bind(index))
	#objective_link.trigger_changed.connect(_link_trigger_changed.bind(location))
	#objective_link.text = "R" + str(_get_index_location(index))
	#objective_link.active = active
	add_child(objective_link_editor)
	move_child(objective_link_editor, index)


func _create_downlink(index: int):
	get_child(index).free() # we can assume there is a dummy here
	var objective_link_editor = objective_link_scene.instantiate()
	var location = _get_index_location(index)
	objective_link_editor.removed.connect(objective_grid.remove_downlink.bind(location))
	objective_link_editor.objective_link = objective_grid.get_downlink(location)
	objective_link_editor.add_link_pressed.connect(_down_link_pressed.bind(location))
	objective_link_editor.orientation = ObjectiveLinkEditor.Orientation.DOWN
	#objective_link_editor.removed.connect(_make_placeholder.bind(index))
	#objective_link.text = "D" + str(_get_index_location(index))
	add_child(objective_link_editor)
	move_child(objective_link_editor, index)


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
	objective_grid.add_rightlink(location, ObjectiveGridLink.new())
	location.x += 1
	var column = location.x * 2
	if column >= columns:
		_vpad(column)
		columns += 2
	_fill_cell(location)


func _down_link_pressed(location: Vector2i):
	objective_grid.add_downlink(location, ObjectiveGridLink.new())
	location.y += 1
	var index = _get_child_index(location)
	var rows = len(get_children()) / columns
	var row = _get_row(index)
	if row >= rows:
		_pad(row)
		rows += 2
	_fill_cell(location)


func _make_placeholder_cell(index: int):
	var c: Control
	for i in [index, index + 1, index + columns]:
		get_child(i).free()
		c = Control.new()
		add_child(c)
		move_child(c, i)


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
	ResourceSaver.save(objective_grid, last_objective_grid.resource_path)
