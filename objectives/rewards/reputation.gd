class_name Reputation
extends Reward

@export var amounts: Dictionary ={# {ReputationType: int} 
		Enums.ReputationType.HELP: 0,
		Enums.ReputationType.HURT: 0
	}

signal reputation_changed


#func new(help: float, hurt: float):
	#amounts[Enums.ReputationType.HELP] = help
	#amounts[Enums.ReputationType.HURT] = hurt


#func _init(help: float = 0, hurt: float = 0):
	#reward_type = Enums.RewardType.REPUTATION
	#for reputation_type in Enums.ReputationType.keys():
		#amounts[reputation_type] = 0
	#amounts[Enums.ReputationType.HELP] = help
	#amounts[Enums.ReputationType.HURT] = hurt



func receive():
	Global.player_game_data.reputation.add(self)


func add(reputation: Reputation):
	for reputation_type in Enums.ReputationType:
		amounts[reputation_type] += reputation.amounts[reputation_type]
	#helpfulness += reputation.helpfulness
	#destructiveness += reputation.destructiveness
	reputation_changed.emit()


func _to_string():
	var result = "("
	for reputation_type in Enums.ReputationType:
		result += str(amounts[reputation_type]) + ", "
	result += ")"
	return result
