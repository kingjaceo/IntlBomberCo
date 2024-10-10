class_name Resources
extends Resource


#@export var stone: int = 0
#@export var bronze: int = 0
#@export var population: int = 0
#@export var food: int = 0
@export var data: Dictionary = Enums.empty_resources_dict.duplicate()


func keys() -> Array[String]:
	return data.keys()

func values() -> Array[int]:
	return data.values()

func has(key: String) -> bool:
	return data.has(key)

func amount(key: String) -> int:
	return data.get(key, 0)

func add(resources: Resources):
	for resource in resources.data:
		data[resource] = data.get(resource, 0) + resources[resource]

func remove(resources: Resources):
	for resource in resources.data:
		data[resource] = max(0, data.get(resource, 0) - resources[resource])
