class_name Trigger
extends Resource

var progress: String:
	get = _get_progress
signal triggered


func activate():
	pass


func _get_progress() -> String:
	return "Abstract Trigger has no Progress."
