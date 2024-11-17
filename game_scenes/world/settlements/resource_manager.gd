class_name ResourceManager
extends Node

# percentage above surplus threshold is surplus (triggers distribution)
@export var surplus_threshold: float = 0.75
# percentage below critical shortage threshold triggers acquisition
@export var critical_shortage_threshold: float = 0.10
var resources: Resources = Resources.new()
var desired_minimum: Resources = Resources.new()
var capacities: Resources = Resources.new()
var distribution_contract: Objective = load("res://objectives/delivery_contracts/distribution_contract.tres")
var production_rate: Resources = Resources.new()

func add(resources_to_add: Resources):
	_update_production_rate(resources_to_add)
	#production_rate.add(production_rate.scale(alpha)) + resources_to_add.scale(1.0 - alpha);
	resources.add(resources_to_add)

func add_resource(resource_type: Enums.ResourceType, amount: int) -> void:
	resources.add_resource(resource_type, amount)

func take(resources_to_remove: Resources):
	resources.remove(resources_to_remove)

func take_resource(resource_type: Enums.ResourceType, amount: int):
	var surplus_amount = surplus(resource_type)
	var amount_taken = min(surplus_amount, amount)
	resources.remove_resource(resource_type, amount_taken)
	return amount_taken

func add_desired_minimum(resources_to_add: Resources):
	desired_minimum.add(resources_to_add)

func add_capacity(additional_capacity: Resources):
	capacities.add(additional_capacity)

func surplus(resource_type: Enums.ResourceType) -> int:
	var have = resources.amount(resource_type)
	var want = desired_minimum.amount(resource_type)
	var surplus_amount = have - want
	return max(surplus_amount, 0)

func has(resources_to_check: Resources) -> bool:
	for resource in resources_to_check.keys():
		if resources.amount(resource) < resources_to_check.amount(resource):
			return false # we don't have enouhg
	return true # we have everything


func get_distribution_contracts() -> Array:
	var distribution_contracts = []
	for resource in Enums.ResourceType.values():
		if surplus(resource) > 0:
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


func _update_production_rate(new_resources: Resources):
	var alpha = 0.9
	# attempt to implement exponential smoothing
	production_rate.scale(alpha).add(new_resources.scale(1.0 - alpha))

#func resource_produced(resource_type: Enums.ResourceType, amount: float):
	#amounts.amount(resource_type) = min(amounts.amount(resource_type) + amount, capacities.amount(resource_type))

#func consume_resource(resource_type: Enums.ResourceType, amount: int) -> bool:
	#if resources.has(resource_type) and amounts.amount(resource_type) >= amount:
		#amounts.amount(resource_type) -= amount
		#return true
	#return false

#func set_capacity(resource_type: Enums.ResourceType, new_capacity: int) -> void:
	#if capacities.has(resource_type):
		#capacities.amount(resource_type) = max(new_capacity, 0)
