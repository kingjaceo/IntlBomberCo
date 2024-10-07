extends ConditionLeaf

@export var radius: float

func tick(actor, blackboard: Blackboard):
	if blackboard.has_value('target'):
		var target = blackboard.get_value('target')
		var distance_to_target = (actor.position - target.position).length()
		if distance_to_target < radius:
			return SUCCESS
	return FAILURE
