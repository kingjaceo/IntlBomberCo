extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	if actor.electricity_power > 0:
		actor.electricity_power -= 1
		actor.wind_power += 1
	return SUCCESS
