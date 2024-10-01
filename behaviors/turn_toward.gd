extends ActionLeaf

const TOLERANCE = PI/20

func tick(actor, blackboard: Blackboard):
	var target = actor.target
	if target:
		var forward: Vector2 = actor.transform.x
		var self_to_target: Vector2 = target.position - actor.position
		var angle_to_target = self_to_target.angle_to(forward)
		if abs(angle_to_target) > TOLERANCE:
			var actual_rotation_speed = actor.rotation_speed * actor.actual_power_levels['wind']
			var rotation_change = get_physics_process_delta_time() * actual_rotation_speed
			actor.rotation_degrees -= rotation_change * sign(angle_to_target)
		return SUCCESS
	return FAILURE
