class_name DestructionTrigger
extends Trigger

@export var building_type: Global.BuildingType
@export var target_amount: int
var current_amount = 0


func activate():
	Events.building_destroyed.connect(_on_building_destroyed)


func _on_building_destroyed(type: int):
	if type & building_type:
		current_amount += 1
		if current_amount >= target_amount:
			triggered.emit()


func _get_progress() -> String:
	return str(round(current_amount / target_amount * 100)) + "%"
