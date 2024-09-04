class_name DestructionTrigger
extends Trigger
@export var target_building_types: Array[Enums.BuildingType]
@export var target_place_names: Array[Enums.PlaceName]
@export var target_amount: int
var current_amount = 0


func activate():
	current_amount = 0
	Events.building_destroyed.connect(_on_building_destroyed)


func _on_building_destroyed(type: int):
	var correct_place = true
	if len(target_place_names) > 0:
		correct_place = Global.current_settlement_data.settlement_name in target_place_names
	var correct_building = true
	if len(target_building_types) > 0:
		correct_building = type in target_building_types
	if correct_place and correct_building:
		_target_destroyed()


func _target_destroyed():
	current_amount += 1
	progress_changed.emit()
	if current_amount >= target_amount:
		triggered.emit()


func _get_progress() -> String:
	return str(current_amount) + " / " + str(target_amount)
