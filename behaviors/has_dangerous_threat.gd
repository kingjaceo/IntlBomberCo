extends ConditionLeaf

@export var dangerous_threshold: int = 80


func tick(actor, blackboard: Blackboard):
	var target = actor.target
	if is_instance_valid(target) and target.threat_level >= dangerous_threshold:
		return SUCCESS
	return FAILURE
