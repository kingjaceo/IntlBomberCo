class_name Settlement
extends WorldLocation

@export var data: SettlementData


func _on_area_detected(area: Area2D):
	if area.owner is AidPackage:
		Events.aid_delivered.emit(area.global_position, data.settlement_name)
	if area.owner is Bomb:
		print("Oh no, you dropped a bomb!!!")
