extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	for system in actor.power_levels:
		actor.power_levels[system] = 0
	return SUCCESS
