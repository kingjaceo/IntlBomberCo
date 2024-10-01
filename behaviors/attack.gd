extends ActionLeaf

@onready var lightning_strike = %LightningStrike


func tick(actor, blackboard: Blackboard):
	if blackboard.has_value('target'):
		var target = blackboard.get_value('target')
		lightning_strike.start(target.position)
		target.damage(actor.attack_damage * actor.spare_power)
	return FAILURE
