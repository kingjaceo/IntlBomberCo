class_name ResourceManager
extends Node

# percentage above surplus threshold is surplus (triggers distribution)
@export var surplus_threshold: float = 0.75
# percentage below critical shortage threshold triggers acquisition
@export var critical_shortage_threshold: float = 0.10
var resources: Dictionary
var capacities: Dictionary
var distribution_contract: Objective = load("res://objectives/delivery_contracts/distribution_contract.tres")


func _ready():
	if not owner.data.resources_data:
		owner.data.resources_data = Resources.new()
	resources = owner.data.resources_data.resources
	capacities = owner.data.resources_data.capacities


func surplus(resource_type) -> int:
	var surplus_limit = capacities[resource_type] * surplus_threshold
	return max(resources[resource_type] - surplus_limit, 0)


func resource_produced(resource_type: Enums.ResourceType, amount: float):
	resources[resource_type] = min(resources[resource_type] + amount, capacities[resource_type])


func add_resource(resource_type: Enums.ResourceType, amount: int) -> void:
	if resources.has(resource_type):
		resources[resource_type] = clamp(resources[resource_type] + amount, 0, capacities[resource_type])


func consume_resource(resource_type: Enums.ResourceType, amount: int) -> bool:
	if resources.has(resource_type) and resources[resource_type] >= amount:
		resources[resource_type] -= amount
		return true
	return false


func set_capacity(resource_type: Enums.ResourceType, new_capacity: int) -> void:
	if capacities.has(resource_type):
		capacities[resource_type] = max(new_capacity, 0)


func get_distribution_contracts() -> Array:
	var distribution_contracts = []
	for resource in resources:
		if resources[resource] > capacities[resource] * surplus_threshold:
			distribution_contracts.append(_get_distribution_contract(resource))
	return distribution_contracts


func _get_distribution_contract(resource_type: Enums.ResourceType) -> Objective:
	var new_reward: Reputation = Reputation.new()
	var new_trigger: ResourceDeliveredTrigger = ResourceDeliveredTrigger.new()
	new_trigger.target_resource_type = resource_type
	new_trigger.target_amount = 10
	new_trigger.target_place_names = Enums.PlaceName.values()
	new_trigger.target_place_names.erase(owner.data.settlement_name)
	var new_contract: Objective = Objective.new()
	new_contract.completion_reward = new_reward
	new_contract.trigger = new_trigger
	return new_contract
