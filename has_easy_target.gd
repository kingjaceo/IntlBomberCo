extends ConditionLeaf

@export var easy_threshold: int = 10

func tick(actor, blackboard: Blackboard):
	var target = actor.target
	if is_instance_valid(target) and target.threat_level <= easy_threshold:
		return SUCCESS
	return FAILURE
