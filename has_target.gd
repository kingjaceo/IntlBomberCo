extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	if blackboard.has_value('target'):
		return SUCCESS
	return FAILURE
