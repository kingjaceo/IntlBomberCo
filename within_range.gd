extends ConditionLeaf
@export var fraction: float = 0.5
@export var range_name: String = "attack_range"


func tick(actor, blackboard: Blackboard) -> int:
	if blackboard.has_value("target"):
		var target = blackboard.get_value("target")
		var distance_to_target = blackboard.get_value("distance_to_target")
		var boundary = blackboard.get_value(range_name) * fraction
		if distance_to_target <= boundary:
			return SUCCESS
	return FAILURE
