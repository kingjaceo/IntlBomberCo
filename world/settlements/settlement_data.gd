class_name SettlementData
extends Resource

@export var settlement_name: Global.PlaceName
@export var contracts: Array[Objective]
@export var max_contracts: int = 1
@export var items: Array[GameItem]
@export var contract_generator: ContractGenerator
var contracts_connected: bool = false
var contracts_completed: int = 0

signal contract_added(contract: Objective)


func generate_contracts():
	if len(contracts) < max_contracts:
		_generate_contract()
	#if not contracts_connected:
		#for contract in contracts:
			#contract.objective_completed.connect(_remove_contract.bind(contract))
		#contracts_connected = true


func _remove_contract(contract: Objective):
	contracts.erase(contract)
	if contract.completed:
		_check_update_contracts_completed()
	if len(contracts) < max_contracts:
		_generate_contract()


func _generate_contract():
	if contract_generator:
		var new_contract = contract_generator.get_new_contract()
		new_contract.objective_completed.connect(_remove_contract.bind(new_contract))
		new_contract.objective_completed.connect(generate_contracts)
		contracts.append(new_contract)
		contract_added.emit(new_contract)


func _check_update_contracts_completed():
	contracts_completed += 1
	if Global.player_game_data.reputation.helpfulness == 1:
		max_contracts += 1
	if contracts_completed == 2:
		contract_generator.unlock_contract("destruction")
