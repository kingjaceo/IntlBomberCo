extends ActionLeaf

@export_enum("NearestSettlement", "FurthestSettlement", "RandomSettlement") var destination_type


func tick(actor, blackboard: Blackboard):	
	match destination_type:
		0: actor.destination = _get_nearest_settlement(actor)	
		1: actor.destination = _get_furthest_settlement(actor)
		2: actor.destination = _get_random_settlement(actor)
	return SUCCESS


func _get_nearest_settlement(actor):
	return false


func _get_furthest_settlement(actor):
	return false


func _get_random_settlement(actor):
	var settlements = get_tree().get_nodes_in_group("settlement")
	var choice = randi_range(0, len(settlements) - 1)
	if len(settlements) > 0:
		return settlements[choice]
