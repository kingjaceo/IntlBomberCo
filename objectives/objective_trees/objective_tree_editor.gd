class_name ObjectiveTreeEditor
extends Control

#@export var objective_tree: ObjectiveTree:
	#set(value):
		#objective_tree = value
		#_draw_tree(objective_tree)
#var cursor_position: Vector2 = Vector2.ZERO
#var objective_editor_scene: PackedScene = load("res://objectives/objective_trees/objective_editor_panel.tscn")
#var objective_gate_scene: PackedScene = load("res://objectives/objective_trees/objective_tree_gate.tscn")
#@export var pad: int = 30
#var last_made_element: Control


#func _draw_tree(tree: ObjectiveTree):
	#var old_cursor_position = cursor_position
	## panel
	#var panel = _make_editor_panel(tree.objective)
	#panel.position = cursor_position
	#cursor_position.y += panel.size.y + pad
	## downgate
	#var gate = _make_downgate()
	#cursor_position.y += pad #gate.size.y / 2 + pad
	#cursor_position.x += panel.size.x / 2 - gate.size.x / 2
	#gate.position = cursor_position
	#cursor_position.y += gate.size.y + pad
	#cursor_position.x = old_cursor_position.x
	## downtree
	#if tree.downtree:
		#cursor_position.y += pad #panel.size.y / 4 + pad
		#_draw_tree(tree.downtree)
	## reset
	#cursor_position = old_cursor_position
	#cursor_position.x += panel.size.x + pad
 	## rightgate
	#gate = _make_rightgate()
	#cursor_position.x += pad
	#cursor_position.y += panel.size.y / 2 - gate.size.y / 2
	#gate.position = cursor_position
	#cursor_position.x += gate.size.x + pad
	#cursor_position.y = old_cursor_position.y
	#if tree.righttree:
		#cursor_position.x += pad
		#_draw_tree(tree.righttree)
	## reset
	#cursor_position = old_cursor_position
func _draw_tree(_objective_tree):
	pass
	## draw panel
	#
	## give the panel a downtree child

#func _make_editor_panel(objective: Objective):
	#var new_panel = objective_editor_scene.instantiate()
	#new_panel.objective = objective
	##new_panel.position = cursor_position
	#add_child(new_panel)
	#return new_panel
	#cursor_position += 
	#last_made_element = new_panel


#func _make_downgate():
	#var new_gate = objective_gate_scene.instantiate()
	##cursor_position = cursor_position + last_made_element.size/2
	##cursor_position.y += new_gate.size.y / 2 + last_made_element.size.y / 2 + pad
	##new_gate.position = cursor_position
	##cursor_position.y += new_gate.size.y / 2 + pad
	#add_child(new_gate)
	#return new_gate


#func _make_rightgate():
	#var new_gate = objective_gate_scene.instantiate()
	##new_gate.position = cursor_position + Vector2(128, 0)
	#add_child(new_gate)
	#return new_gate
	#add_child(new_gate)


#func _redraw() -> void:
	#for child in get_children():
		#if child.name != "Button":
			#child.queue_free()
	#
	#_draw_tree(objective_tree)
