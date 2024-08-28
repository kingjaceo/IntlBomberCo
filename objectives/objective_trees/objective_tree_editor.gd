class_name ObjectiveTreeEditor
extends Control

@export var objective_tree: ObjectiveTree:
	set(value):
		objective_tree = value
		_draw_tree(objective_tree)
var cursor_position: Vector2 = Vector2.ZERO
var objective_editor_scene: PackedScene = load("res://objectives/objective_trees/objective_editor_panel.tscn")
var objective_gate_scene: PackedScene = load("res://objectives/objective_trees/objective_tree_gate.tscn")
@export var pad: int = 30
var last_made_element: Control

func _draw_tree(tree: ObjectiveTree):
	_make_editor_panel(tree.objective)
	_make_downgate(tree.downgate)
	_make_rightgate(tree.rightgate)
	var old_cursor_position = cursor_position
	if tree.downtree:
		cursor_position.y = old_cursor_position.y + last_made_element.size.y + pad
		_draw_tree(tree.downtree)
	cursor_position = old_cursor_position
	if tree.righttree:
		cursor_position.x = old_cursor_position.x + last_made_element.size.x + pad
		_draw_tree(tree.righttree)
	cursor_position = old_cursor_position


func _make_editor_panel(objective: Objective):
	var new_panel = objective_editor_scene.instantiate()
	new_panel.objective = objective
	new_panel.position = cursor_position
	add_child(new_panel)
	last_made_element = new_panel


func _make_downgate(gate: ObjectiveTreeGate):
	var new_gate = objective_gate_scene.instantiate()
	new_gate.position = cursor_position + Vector2(0, 128)
	new_gate.rotation = - PI/2
	add_child(new_gate)


func _make_rightgate(gate: ObjectiveTreeGate):
	var new_gate = objective_gate_scene.instantiate()
	new_gate.position = cursor_position + Vector2(128, 0)
	add_child(new_gate)


func _redraw() -> void:
	for child in get_children():
		if child.name != "Button":
			child.queue_free()
	
	_draw_tree(objective_tree)
