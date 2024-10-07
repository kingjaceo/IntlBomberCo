extends ActionLeaf

@export var system: String
@export var amount: int


func tick(actor, blackboard: Blackboard):
	for system in actor.power_levels:
		actor.power_levels[system] = 0
	
	_assign_power(actor)
	_distribute_power(actor)
	
	return SUCCESS


func _assign_power(actor):
	actor.power_levels[system] = min(amount, actor.max_power_level)


func _distribute_power(actor):
	var amount_to_distribute = max(0, actor.max_power_level - amount)
	while amount_to_distribute > 0:
		for _system in actor.power_levels:
			if _system != system:
				actor.power_levels[_system] += 1
				amount_to_distribute -= 1
			
	
