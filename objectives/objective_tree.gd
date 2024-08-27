class_name ObjectiveTree
extends Resource

var frontier: Array[Objective]
@export var objective: Objective
@export var downgate: ObjectiveTreeGate
@export var downtree: ObjectiveTree
@export var rightgate: ObjectiveTreeGate
@export var righttree: ObjectiveTree


func get_frontier() -> Array[Objective]:
	if not downgate.open and not rightgate.open:
		frontier.append(objective)
		return frontier
	if downgate.open:
		frontier.append(downtree.get_frontier())
	if rightgate.open:
		frontier.append(righttree.get_frontier())
	return frontier
