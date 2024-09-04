class_name ContractGeneratorDEPRECATED
extends Node

var game_data: GameData
var generator_data: ContractGeneratorDataDEPRECATED


func _ready():
	game_data = Global.game_data
	generator_data = game_data.generator_data
	for contract in game_data.contracts:
		contract.objective_completed.connect(_update_contracts)
	_update_contracts()


func _update_contracts():
	while _needs_new_contract():
		var new_contract = _generate_new_contract()
		game_data.add_contract(new_contract)


func _needs_new_contract():
	return len(game_data.contracts) < game_data.contract_capacity


func _generate_new_contract():
	var new_contract_type = _get_new_contract_type()
	match new_contract_type:
		"aid":
			return _make_new_aid_contract()
		"destruction":
			return _make_new_destruction_contract()


func _get_new_contract_type():
	if generator_data.contracts_generated_by_type["aid"] <= generator_data.contracts_generated_by_type["destruction"]:
		return "aid"
	return "destruction"


func _make_new_aid_contract():
	var new_contract = Objective.new()
	generator_data.contracts_generated_by_type["aid"] += 1
	new_contract.name = "Aid Contract #" + str(generator_data.contracts_generated_by_type["aid"])
	new_contract.description = "Feed the people! Deliver 3 aid packages."
	
	var aid_trigger = AidTrigger.new()
	aid_trigger.target_amount = 3
	new_contract.trigger = aid_trigger
	
	var upfront_reward = CashReward.new()
	upfront_reward.amount = 3000
	new_contract.upfront_reward = upfront_reward
	
	var completion_reward = CashReward.new()
	completion_reward.amount = 5000
	new_contract.completion_reward = completion_reward
	
	new_contract.objective_completed.connect(_update_contracts)
	return new_contract


func _make_new_destruction_contract():
	var new_contract = Objective.new()
	generator_data.contracts_generated_by_type["destruction"] += 1
	new_contract.name = "Destruction Contract #" + str(generator_data.contracts_generated_by_type["destruction"])
	new_contract.description = "Our enemies must be destroyed! Destroy 1 military building (red)."
	
	var destruction_trigger = DestructionTrigger.new()
	destruction_trigger.building_type = Enums.BuildingType.MILITARY
	destruction_trigger.target_amount = 1
	new_contract.trigger = destruction_trigger
	
	var upfront_reward = CashReward.new()
	upfront_reward.amount = 3000
	new_contract.upfront_reward = upfront_reward
	
	var completion_reward = CashReward.new()
	completion_reward.amount = 20000
	new_contract.completion_reward = completion_reward
	
	new_contract.objective_completed.connect(_update_contracts)
	return new_contract
