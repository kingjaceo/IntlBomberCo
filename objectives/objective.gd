class_name Objective
extends Resource

@export var name: String
@export var description: String
@export var flavor_text: String
@export var upfront_reward: Reward
@export var completion_reward: Reward
@export var trigger: Trigger
var progress: String:
	get = _get_progress
@export var accepted: bool
@export var completed: bool

## defines an ObjectiveTree data structure
@export var down_trigger: Trigger
@export var down_objective: Objective
@export var right_trigger: Trigger
@export var right_objective: Objective


signal triggered
signal progress_changed
signal objective_completed


func accept(): # called when contract is accepted by player
	accepted = true
	activate()
	if upfront_reward:
		upfront_reward.receive()


func activate(): # called when contract is loaded into memory or accepted
	trigger.activate()
	trigger.triggered.connect(_on_trigger)
	trigger.progress_changed.connect(progress_changed.emit)


func complete(): # called when the objective is "turned in" by the player
	completion_reward.receive()
	objective_completed.emit()


func _on_trigger():
	completed = true
	triggered.emit()


func _get_progress():
	if trigger:
		return trigger.progress
