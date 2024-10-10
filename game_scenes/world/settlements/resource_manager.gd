class_name ResourceManager
extends Node

# percentage above surplus threshold is surplus (triggers distribution)
@export var surplus_threshold: float = 0.75
# percentage below critical shortage threshold triggers acquisition
@export var critical_shortage_threshold: float = 0.10
var resources: Resources
var capacities: Resources
var distribution_contract: Objective = load("res://objectives/delivery_contracts/distribution_contract.tres")


func add(resources_to_add: Resources):
	resources.add(resources_to_add)

func take(resources_to_remove: Resources):
	resources.remove(resources_to_remove)

func add_capacity(additional_capacity: Resources):
	capacities.add(additional_capacity)

func surplus(resource_type: String) -> int:
	var surplus_limit = capacities.amount(resource_type) * surplus_threshold
	return max(resources.amount(resource_type) - surplus_limit, 0)

func has(resources_to_check: Resources) -> bool:
	for resource in resources_to_check.keys():
		if resources.amount(resource) < resources_to_check.amount(resource):
			return false # we don't have enouhg
	return true # we have everything

#func resource_produced(resource_type: Enums.ResourceType, amount: float):
	#amounts.amount(resource_type) = min(amounts.amount(resource_type) + amount, capacities.amount(resource_type))


#func add_resource(resource_type: Enums.ResourceType, amount: int) -> void:
	#if resources.has(resource_type):
		#amounts.amount(resource_type) += amount
	#else:
		#amounts.amount(resource_type) = amount


#func consume_resource(resource_type: Enums.ResourceType, amount: int) -> bool:
	#if resources.has(resource_type) and amounts.amount(resource_type) >= amount:
		#amounts.amount(resource_type) -= amount
		#return true
	#return false


#func set_capacity(resource_type: Enums.ResourceType, new_capacity: int) -> void:
	#if capacities.has(resource_type):
		#capacities.amount(resource_type) = max(new_capacity, 0)


func get_distribution_contracts() -> Array:
	var distribution_contracts = []
	for resource in Enums.resource_types:
		if resources.amount(resource) > capacities.amount(resource) * surplus_threshold:
			distribution_contracts.append(_get_distribution_contract(resource))
	return distribution_contracts


func _get_distribution_contract(resource_type: String) -> Objective:
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
