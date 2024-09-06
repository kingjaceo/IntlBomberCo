class_name Trigger
extends Resource

var progress: String:
	get = _get_progress
var trigger_type: Enums.TriggerType


signal triggered
signal progress_changed


func activate():
	pass


func _get_progress() -> String:
	return "Abstract Trigger has no Progress."
