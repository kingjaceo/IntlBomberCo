class_name GameData
extends Resource


@export var contracts: Array[Objective]
@export var money: int = 10000:
	set(value):
		money = value
		money_changed.emit()

var objectives: Array[Objective]
var buildings_destroyed: int = 0
var aid_delivered: int = 0
var active_item: GameItem
@export var tutorial_active: bool = true
@export var contract_capacity: int = 1
@export var generator_data: ContractGeneratorData

signal money_changed
signal planes_updated
signal contracts_updated
signal objectives_updated


func _on_building_destroyed():
	money += 1000
	buildings_destroyed += 1


func _on_aid_delivered():
	aid_delivered += 1


func add_contract(contract: Objective):
	contracts.append(contract)
	contracts_updated.emit()
	contract.objective_completed.connect(_contract_completed.bind(contract))


func _contract_completed(contract: Objective):
	contracts.erase(contract)
	contracts_updated.emit()
