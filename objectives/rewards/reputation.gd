class_name Reputation
extends Reward

@export var amounts: Dictionary # {ReputationType: int}

signal reputation_changed


func _init():
	reward_type = Enums.RewardType.REPUTATION
	for reputation_type in Enums.ReputationType:
		amounts[reputation_type] = 0


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
