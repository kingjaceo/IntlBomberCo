class_name BuildingData
extends Resource

@export var name: String = "DummyBuilding"
@export var building_type: Enums.BuildingType
@export var building_cost: Resources
@export var produced_resources: Resources = Resources.new()
@export var production_cycle_time: float # seconds
@export var consumed_resources: Resources = Resources.new()
@export var consumption_cycle_time: float # seconds
@export var additional_capacity: Resources = Resources.new()
@export var desired_minimum: Resources = Resources.new()
@export var required_features: Array[Enums.SettlementFeature] = []
@export var build_time: float = 5
var production_rate: Resources:
	get:
		production_rate = produced_resources.copy()
		production_rate.scale(1 / production_cycle_time)
		return production_rate
var consumption_rate: Resources:
	get:
		consumption_rate = consumed_resources.copy()
		consumption_rate.scale(1 / consumption_cycle_time)
		return consumption_rate
