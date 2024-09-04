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
var objective_editor_panel: PackedScene = load("res://objectives/objective_trees/objective_editor.tscn")
var objective_tree: PackedScene = load("res://objectives/objective_trees/objective_tree.tscn")


func _ready():
	for child in get_children():
		child.queue_free()
	# recursively create a new right and downtrees
	if objective:
		_create_add_editor()
		if objective.right_objective:
			_create_add_tree(objective.right_objective)
		else:
			add_child(Control.new())
		if objective.down_objective:
			_create_add_tree(objective.down_objective)


func _create_add_editor():
	var new_editor = objective_editor_panel.instantiate()
	new_editor.objective = objective
	add_child(new_editor)


func _create_add_tree(objective: Objective):
	var new_tree = objective_tree.instantiate()
	new_tree.objective = objective
	add_child(new_tree)


#func get_frontier() -> Array[Objective]:
	#if not downgate.open and not rightgate.open:
		#frontier.append(objective)
		#return frontier
	#if downgate.open:
		#frontier.append(downtree.get_frontier())
	#if rightgate.open:
		#frontier.append(righttree.get_frontier())
	#return frontier
