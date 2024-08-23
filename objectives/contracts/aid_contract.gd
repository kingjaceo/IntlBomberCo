class_name AidContractDEPRECATED
extends Objective

@export var target_amount: int
var current_amount: int = 0

func activate():
	super.activate()
	Events.aid_delivered.connect(_on_aid_delivered)


func _on_aid_delivered(_location: Vector2):
	current_amount += 1
	if current_amount >= target_amount:
		completed = true
		objective_completed.emit()


func get_progress():
		var percent = roundf(float(current_amount) / float(target_amount) * 100)
		return "%s" % percent + "% (" + str(current_amount) + "/" + str(target_amount) + ")"
