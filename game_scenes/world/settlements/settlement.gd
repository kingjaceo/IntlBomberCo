class_name Settlement
extends WorldLocation

@export var data: SettlementData
var place_name: Enums.PlaceName
@onready var town_name_label = $"Town Name"
@onready var resource_manager: ResourceManager = %ResourceManager
@onready var building_manager: BuildingManager = %BuildingManager
@onready var resources_display: ResourcesDisplay = %ResourcesDisplay


func _ready():
	if not data.resources_data:
		data.resources_data = Resources.new()
	place_name = data.settlement_name
	Global.settlements[data.settlement_name] = self
	town_name_label.text = Enums.PlaceName.keys()[data.settlement_name]
	resources_display.resources = data.resources_data
	resource_manager.resources = data.resources_data
	#building_manager.resource_produced.connect(_resource_produced)


func take_resources_from_settlement(resources: Resources):
	# request may be more than available, take as much as possible
	var resources_available = resource_manager.take(resources)
	return resources_available


func give_resources_to_settlement(resources: Resources):
	resource_manager.add(resources)


func increase_resource_capacity(additional_capacity: Resources):
	resource_manager.add_capacity(additional_capacity)


func has(resources: Resources) -> bool:
	return resource_manager.has(resources)


func get_available_contracts() -> Array:
	return resource_manager.get_distribution_contracts()


func _on_area_detected(area: Area2D):
	if area.owner is AidPackage:
		Events.aid_delivered.emit(area.global_position, data.settlement_name)
	if area.owner is Bomb:
		print("Oh no, you dropped a bomb!!!")

#
#func _resource_produced(resource_type: Enums.ResourceType, amount: float):
	#resource_manager.resource_produced(resource_type, amount)

# DEPRECATED
#func receive(resource_type: Enums.ResourceType, amount: int):
	#resource_manager.add_resource(resource_type, amount)
#
#func request(resource_type: Enums.ResourceType, amount: int):
	#var amount_to_take = min(amount, resource_manager.surplus(resource_type))
	#resource_manager.consume_resource(resource_type, amount_to_take)
	#return amount_to_take
