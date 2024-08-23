class_name Settlement
extends WorldLocation

@export var data: SettlementData
@onready var town_name = $"Town Name"


func _ready():
	town_name.text = Global.PlaceName.keys()[data.settlement_name]
	for contract in data.contracts:
		contract.objective_completed.connect(_remove_contract)


func _remove_contract(contract: Objective):
	data.contracts.erase(contract)


func _on_area_detected(area: Area2D):
	if area.owner is AidPackage:
		Events.aid_delivered.emit(area.global_position, data.settlement_name)
	if area.owner is Bomb:
		print("Oh no, you dropped a bomb!!!")
