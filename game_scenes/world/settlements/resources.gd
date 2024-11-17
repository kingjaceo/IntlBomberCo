class_name Resources
extends Resource

@export var data: Dictionary[Enums.ResourceType, float]


func keys() -> Array[Enums.ResourceType]:
	return data.keys()

func values() -> Array[float]:
	return data.values()

func has(resource_type: Enums.ResourceType) -> bool:
	return resource_type in data.keys()

func amount(resource: Enums.ResourceType) -> float:
	return data.get(resource, 0)

func add(resources: Resources):
	for resource in resources.data:
		data[resource] = amount(resource) + resources.amount(resource)

func add_resource(resource_type: Enums.ResourceType, amount: float):
	if has(resource_type):
		data[resource_type] += amount
	else:
		data[resource_type] = amount

func remove(resources: Resources):
	for resource in resources.data:
		data[resource] = max(0, amount(resource) - resources.amount(resource))

func remove_resource(resource_type: Enums.ResourceType, amount: float):
	data[resource_type] -= amount

func greater_than_or_equal(comparison_resources: Resources) -> bool:
	for resource in data:
		if amount(resource) < comparison_resources.amount(resource):
			return false
	return true

func scale(factor: float):
	for resource in data:
		data[resource] *= factor

func weighted_sum() -> float:
	var total = 0
	for resource in data:
		total += amount(resource) * Enums.ResourceWeights[resource]
	return total


func copy() -> Resources:
	var new_copy = Resources.new()
	new_copy.data = data.duplicate()
	return new_copy
