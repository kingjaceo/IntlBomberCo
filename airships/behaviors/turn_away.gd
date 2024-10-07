extends ActionLeaf

const TOLERANCE = 0
@export var RELATIVE_HEADING = PI/2

func tick(actor, blackboard: Blackboard):
	var target = actor.target
	if target:
		var forward: Vector2 = actor.transform.x
		var target_forward: Vector2 = target.transform.x
		var angle_to_target = forward.angle_to(target_forward)
		if abs(angle_to_target) < RELATIVE_HEADING - TOLERANCE:
			var actual_rotation_speed = actor.rotation_speed * actor.actual_power_levels['wind']
			var rotation_change = get_physics_process_delta_time() * actual_rotation_speed
			if angle_to_target >= 0:
				actor.rotation_degrees -= rotation_change
			else:
				actor.rotation_degrees += rotation_change
	return SUCCESS
