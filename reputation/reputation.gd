class_name Reputation
extends Resource

@export var helpfulness: float
@export var destructiveness: float

signal reputation_changed


func add(reputation: Reputation):
	helpfulness += reputation.helpfulness
	destructiveness += reputation.destructiveness
	reputation_changed.emit()

func _to_string():
	return "(" + str(helpfulness) + ", " + str(destructiveness) + ")"
