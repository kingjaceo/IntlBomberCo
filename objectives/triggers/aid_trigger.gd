class_name AidTrigger
extends Trigger

@export var target_amount: int
var current_amount = 0


func activate():
	Events.aid_delivered.connect(_on_aid_delivered)


func _on_aid_delivered(_position: Vector2, location: Enums.PlaceName):
	current_amount += 1
	if current_amount >= target_amount:
		triggered.emit()


func _get_progress() -> String:
	#return Utility.format_percent(current_amount, target_amount)
	return Utility.format_ratio(current_amount, target_amount)
