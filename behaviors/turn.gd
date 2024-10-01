extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	actor.rotation_degrees += 0 * actor.rotation_change
	return SUCCESS
