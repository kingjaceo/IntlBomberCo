class_name ContractGenerator
extends Resource

var game_data: GameData
var number_completed_contracts_by_type: Dictionary = {"aid": 0, "destruction": 0, "story": 0}

func _on_contract_completed():
	while _needs_new_contract():
		var new_contract = _generate_new_contract()
		game_data.contracts.append(new_contract)


func _needs_new_contract():
	return len(game_data.contracts) < game_data.contract_capacity


func _generate_new_contract():
	if number_completed_contracts_by_type["aid"] < 3:
		var new_contract = AidContract.new()
		new_contract.name = "Aid Contract #" + str(number_completed_contracts_by_type["aid"] + 1)
		new_contract.target_amount = 3
		new_contract.upfront_reward = CashReward.new()
		new_contract.upfront_reward.amount = 3000
		new_contract.completion_reward = CashReward.new()
		new_contract.completion_reward.amount = 5000
		new_contract.contract_completed.connect(_on_contract_completed)
# whenever a contract gets completed, the ContractGenerator needs to:
#  1) decide if a new contract is needed
#  2) decide to create a new contract
