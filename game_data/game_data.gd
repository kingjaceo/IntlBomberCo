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
@export var reputation: Reputation:
	set(value):
		reputation = value
		reputation.reputation_changed.connect(reputation_changed.emit)
		#reputation_changed.emit()

signal money_changed
signal reputation_changed
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
	contract.objective_completed.connect(call_deferred.bind("_contract_completed", contract))


func _contract_completed(contract: Objective):
	contracts.erase(contract)
	contracts_updated.emit()
