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
@export var available: bool = false
@export var accepted: bool
@export var completed: bool

signal triggered
signal progress_changed
signal objective_completed


func accept(): # called when contract is accepted by player
	accepted = true
	#activate() # need to activate this, probably
	if upfront_reward:
		upfront_reward.receive()


func activate(ship: Ship, location: Settlement): # called when contract is loaded into memory or accepted
	trigger.activate(ship, location)
	trigger.triggered.connect(_on_trigger)
	trigger.progress_changed.connect(progress_changed.emit)


func try_complete(ship: Ship, location: Settlement) -> bool:
	if trigger.try_complete(ship, location):
		ship.complete(self)
		return true
	return false


func complete(): # called when the objective is "turned in" by the player
	completion_reward.receive()
	objective_completed.emit()


func _on_trigger():
	completed = true
	triggered.emit()


func _get_progress():
	if trigger:
		return trigger.progress
