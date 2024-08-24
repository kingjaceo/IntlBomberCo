class_name ReputationReward
extends Reward

@export var reputation: Reputation


func receive():
	Global.player_game_data.reputation.add(reputation)


func _to_string():
	return str(reputation)
