extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	if actor.confidence > 1:
		return SUCCESS
	return FAILURE
