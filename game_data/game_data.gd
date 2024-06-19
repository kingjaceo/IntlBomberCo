class_name GameData
extends Resource


@export var current_plane: Airplane
@export var items: Array[GameItem]
@export var planes: Array[Airplane]
@export var contracts: Array[Contract]
@export var active_contracts: Array[Contract]
@export var contract_pool: Array[Contract]
@export var money: int = 10000:
	set(value):
		money = value
		money_changed.emit()
@export var contract_generator: ContractGenerator
var buildings_destroyed: int = 0
var aid_delivered: int = 0
var active_item: GameItem
@export var tutorial_active: bool = true
var contract_capacity: int = 1

signal money_changed
signal planes_updated
signal contracts_updated


func _on_building_destroyed():
	money += 1000
	buildings_destroyed += 1


func _on_aid_delivered():
	aid_delivered += 1


func add_plane(plane: Airplane):
	planes.append(plane)
	planes_updated.emit()



func on_contract_completed(contract: Contract):
	contracts.erase(contract)
	var num_new_contracts = min(len(contract_pool), contract_capacity - len(contracts))
	for i in range(num_new_contracts):
		var new_contract = contract_pool.pop_front()
		contracts.append(new_contract)
	contracts_updated.emit()
