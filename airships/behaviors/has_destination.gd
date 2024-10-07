extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	if actor.destination:
		return SUCCESS
	return FAILURE
