class_name ContractDEPRECATED
extends Resource

@export var name: String
@export var description: String
@export var upfront_reward: Reward
@export var completion_reward: Reward
#@export var focus: Focus
@export var trigger: Trigger
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
	Global.game_data.remove_contract(self)
	print(get_signal_connection_list("contract_completed"))
	contract_completed.emit()
	completion_reward.receive()


func get_progress():
	return "0 %"


func get_description():
	return description
