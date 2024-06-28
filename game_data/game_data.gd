class_name GameData
extends Resource


@export var current_plane: Airplane
@export var items: Array[GameItem]
@export var planes: Array[Airplane]
@export var contracts: Array[Contract]
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


func add_plane(plane: Airplane):
	planes.append(plane)
	planes_updated.emit()


func add_objective(objective: Objective):
	objectives.append(objective)
	objectives_updated.emit()
	objective.objective_completed.connect(_objective_completed)


func _objective_completed(objective: Objective):
	objectives.erase(objective)
	objectives.erase(objective)
	objectives_updated.emit()
