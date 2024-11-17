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
	resource_manager.take(resources)

func take_resource_from_settlement(resource_type: Enums.ResourceType, amount: int) -> int:
	var resource_available = resource_manager.take_resource(resource_type, amount)
	return resource_available

func give_resources_to_settlement(resources: Resources):
	resource_manager.add(resources)

func give_resource_to_settlement(resource_type: Enums.ResourceType, amount: int):
	resource_manager.add_resource(resource_type, amount)

func increase_resource_capacity(additional_capacity: Resources):
	resource_manager.add_capacity(additional_capacity)

func increase_desired_minimum(desired_minimum: Resources):
	resource_manager.add_desired_minimum(desired_minimum)

func has(resources: Resources) -> bool:
	return resource_manager.has(resources)

func get_available_contracts() -> Array:
	return resource_manager.get_distribution_contracts()


func _on_area_detected(area: Area2D):
	if area.owner is AidPackage:
		Events.aid_delivered.emit(area.global_position, data.settlement_name)
	if area.owner is Bomb:
		print("Oh no, you dropped a bomb!!!")
