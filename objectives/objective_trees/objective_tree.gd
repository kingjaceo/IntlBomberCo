class_name ObjectiveTree
extends GridContainer
'''
ObjectiveTrees are always 2x2 GridContainers such that:
	(0, 0) is the ObjectiveEditorPanel for objective
	(1, 0) is the ObjectiveTree for righttree
	(0, 1) is the ObjectiveTree for downtree
	(1, 1) is reserved dead space and never used
'''
var frontier: Array[Objective]
@export var objective: Objective
var objective_editor_scene: PackedScene = load("res://objectives/objective_trees/objective_editor.tscn")
var objective_tree_scene: PackedScene = load("res://objectives/objective_trees/objective_tree.tscn")
var objective_editor: ObjectiveEditor

func _ready():
	if objective:
		for child in get_children():
			child.free()
		# instantiate elements
		_create_add_editor() # must get added first
		if objective.right_objective:
			_create_righttree() # must get added second
		else:
			add_child(Control.new()) # to fill a dummy slot in the grid
		if objective.down_objective:
			_create_downtree() # must get added third


func _create_add_editor():
	var new_editor = objective_editor_scene.instantiate()
	objective_editor = new_editor
	objective_editor.objective = objective
	if objective.right_objective:
		objective_editor.disable_rightlink()
	objective_editor.rightlink_pressed.connect(_create_righttree)
	if objective.down_objective:
		objective_editor.disable_downlink()
	objective_editor.downlink_pressed.connect(_create_downtree)
	add_child(objective_editor)


func _create_add_tree(objective: Objective):
	var new_tree = objective_tree_scene.instantiate()
	new_tree.objective = objective
	add_child(new_tree)


func _create_righttree():
	# there must always be a control in position (1, 0)
	# of the grid container
	# so: delete the current control, set self to be the 2nd child
	objective_editor.disable_rightlink()
	if get_child_count() > 1:
		get_child(1).free()
	var new_tree = objective_tree_scene.instantiate()
	if objective.right_objective:
		new_tree.objective = objective.right_objective
	else:
		new_tree.objective = Objective.new()
		objective.right_objective = new_tree.objective
	add_child(new_tree)
	move_child(new_tree, 1)


func _create_downtree():
	objective_editor.disable_downlink()
	var new_tree = objective_tree_scene.instantiate()
	if objective.down_objective:
		new_tree.objective = objective.down_objective
	else:
		new_tree.objective = Objective.new()
		objective.down_objective = new_tree.objective
	add_child(new_tree)


func _save():
	ResourceSaver.save(objective, "test_objective_tree.tres")
#func get_frontier() -> Array[Objective]:
	#if not downgate.open and not rightgate.open:
		#frontier.append(objective)
		#return frontier
	#if downgate.open:
		#frontier.append(downtree.get_frontier())
	#if rightgate.open:
		#frontier.append(righttree.get_frontier())
	#return frontier
