extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	if actor.wind_power > 0:
		actor.wind_power -= 1
		actor.electricity_power += 1
	return SUCCESS
