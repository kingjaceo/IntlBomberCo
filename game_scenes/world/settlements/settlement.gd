class_name Settlement
extends WorldLocation

@export var data: SettlementData
var place_name: Enums.PlaceName
@onready var town_name_label = $"Town Name"
@onready var resource_manager: ResourceManager = %ResourceManager


func _ready():
	place_name = data.settlement_name
	Global.settlements[data.settlement_name] = self
	town_name_label.text = Enums.PlaceName.keys()[data.settlement_name]
	for c in get_children():
		if c.has_signal("resource_produced"):
			c.resource_produced.connect(_resource_produced)

func request(resource_type: Enums.ResourceType, amount: int, hold: Hold):
	var amount_to_take = min(amount, resource_manager.surplus(resource_type))
	var amount_taken = hold.add(resource_type, amount_to_take)
	resource_manager.consume_resource(resource_type, amount_taken)
		

func get_available_contracts() -> Array:
	return resource_manager.get_distribution_contracts()


func _on_area_detected(area: Area2D):
	if area.owner is AidPackage:
		Events.aid_delivered.emit(area.global_position, data.settlement_name)
	if area.owner is Bomb:
		print("Oh no, you dropped a bomb!!!")


func _resource_produced(resource_type: Enums.ResourceType, amount: float):
	resource_manager.resource_produced(resource_type, amount)
