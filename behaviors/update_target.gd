extends ActionLeaf

@export var detection_area: Area2D

## TODO: for efficiency, this node should figure out how to CACHE
## a target and listen for conditions that it should check again
## explicitly checking for overlapping areas each frame is ok for now
func tick(actor, blackboard: Blackboard):
	var targets = detection_area.get_overlapping_areas()
	if len(targets) < 2:
		return FAILURE
	var target = _choose_target(actor, targets)
	var distance_to_target = (target.position - actor.position).length()
	blackboard.set_value("target", target)
	blackboard.set_value("distance_to_target", distance_to_target)
	actor.target = target
	return SUCCESS


func _choose_target(actor, targets: Array):
	if targets[0].owner == actor:
		return targets[1].owner
	return targets[0].owner
