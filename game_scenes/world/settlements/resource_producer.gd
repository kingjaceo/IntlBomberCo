class_name ResourceProducerDEPRECATED
extends Resource

@export var resource_type: Enums.ResourceType
@export var production_rate: float # units per second
@export var packet_size: int # how much we send to the ResourceManager
var amount: float

signal resource_produced(resource_type: Enums.ResourceType, amount: float)


func process(delta):
	amount += delta * production_rate
	if amount > packet_size:
		amount -= packet_size
		resource_produced.emit(resource_type, packet_size)
