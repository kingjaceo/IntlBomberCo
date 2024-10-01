extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	actor.rotation_degrees += 1
	return SUCCESS
