class_name SettlementData
extends Resource

@export var settlement_name: Enums.PlaceName
@export var resources_data: Resources
@export var bulidings_data: Buildings
@export var objective_grid: ObjectiveGrid
@export var items: Array[GameItem]

signal contract_added

func get_objectives() -> Array[Objective]:
	if objective_grid:
		return objective_grid.frontier()
	else:
		return []
