class_name Objective
extends Resource

enum ObjectiveType {ACHIEVEMENT, OBJECTIVE, CONTRACT}
@export var name: String
@export var description: String
@export var objective_type: ObjectiveType
@export var upfront_reward: Reward
@export var completion_reward: Reward
@export var focus: Focus
@export var trigger: Trigger
var progress: String:
	get = _get_progress
var accepted: bool
var completed: bool

signal triggered
signal objective_completed


func accept():
	accepted = true
	if upfront_reward:
		upfront_reward.receive()
	if focus:
		focus.highlight()
	trigger.triggered.connect(_on_trigger)


func complete():
	completion_reward.receive()
	objective_completed.emit()


func _on_trigger():
	completed = true
	triggered.emit()


func _get_progress():
	if trigger:
		return trigger.progress
