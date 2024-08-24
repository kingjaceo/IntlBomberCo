class_name Settlement
extends WorldLocation

@export var data: SettlementData
@onready var town_name_label = $"Town Name"


func _ready():
	town_name_label.text = Global.PlaceName.keys()[data.settlement_name]
	data.connect_contracts()


func _on_area_detected(area: Area2D):
	if area.owner is AidPackage:
		Events.aid_delivered.emit(area.global_position, data.settlement_name)
	if area.owner is Bomb:
		print("Oh no, you dropped a bomb!!!")
