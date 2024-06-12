class_name DestructionContract
extends Contract

@export var target: BuildingType
@export var target_amount: int
var current_amount: int = 0


func activate():
	accepted = true
	upfront_reward.receive()
	Events.building_destroyed.connect(_on_building_destroyed)


func _on_building_destroyed(building_type: int):
	if building_type & target.building_type:
		current_amount += 1
		if current_amount >= target_amount:
			completed = true


func get_progress():
		var percent = roundf(float(current_amount) / float(target_amount) * 100)
		return "%s" % percent + "% (" + str(current_amount) + "/" + str(target_amount) + ")"


func get_description():
	return "We need you to destroy %s buildings" % target_amount
