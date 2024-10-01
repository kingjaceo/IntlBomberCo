extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	var actual_speed = actor.forward_speed * actor.actual_power_levels['wind']
	var position_change = actor.transform.x * actual_speed * get_process_delta_time()
	actor.position += position_change
	return SUCCESS
