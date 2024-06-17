class_name Contract
extends Resource

@export var name: String
@export var description: String:
	get = get_description
@export var upfront_reward: Reward
@export var completion_reward: Reward
var progress: String:
	get = get_progress
var accepted: bool
var completed: bool

signal condition_satisfied
signal contract_completed

func activate():
	accepted = true
	if upfront_reward:
		upfront_reward.receive()


func satisfy_condition():
	completed = true
	condition_satisfied.emit()


func complete():
	contract_completed.emit()
	completion_reward.receive()


func get_progress():
	return "0 %"


func get_description():
	return description
