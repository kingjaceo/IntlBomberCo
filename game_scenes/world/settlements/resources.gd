class_name Resources
extends Resource

@export var resources: Dictionary = {} # {resource_type: amount}
@export var capacities: Dictionary = {} # {resource_type: capacity}


func _init():
	if len(resources) == 0:
		for resource_type in Enums.ResourceType.values():
			resources[resource_type] = 0
			capacities[resource_type] = 100
