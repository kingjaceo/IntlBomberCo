class_name AidTrigger
extends Trigger

@export var target_amount: int
var current_amount = 0


func activate():
	Events.aid_delivered.connect(_on_aid_delivered)


func _on_aid_delivered(_location: Vector2):
	current_amount += 1
	if current_amount >= target_amount:
		triggered.emit()


func _get_progress() -> String:
	return str(round(current_amount / target_amount * 100)) + "%"
