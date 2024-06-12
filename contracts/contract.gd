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


func activate():
	accepted = true
	upfront_reward.receive()


func complete():
	completion_reward.receive()


func get_progress():
	return "0 %"


func get_description():
	return "This contract is meaningless."
