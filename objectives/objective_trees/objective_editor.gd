class_name ObjectiveEditor
extends Control

@onready var objective_name: TextEdit = %ObjectiveName
@onready var description: TextEdit = %Description
@onready var flavor_text: TextEdit = %FlavorText
var objective: Objective#:
	#set(value):
		#objective = value
		#_populate_fields()


var rewards: Dictionary = {
	Enums.RewardType.NONE: false,
	Enums.RewardType.REPUTATION: Reputation,
	Enums.RewardType.VICTORY: Reward,
}

signal rightlink_pressed
signal downlink_pressed


func _ready():
	if objective:
		_populate_fields()


func disable_rightlink():
	%Rightlink.disabled = true

func disable_downlink():
	%Downlink.disabled = true


func _populate_fields():
	if objective_name:
		objective_name.text = objective.name
	if description:
		description.text = objective.description
	if flavor_text:
		flavor_text.text = objective.flavor_text
		
	if objective.upfront_reward:
		%UpfrontReward.select(objective.upfront_reward.reward_type)
		%UpfrontRewardEditor.reward = objective.upfront_reward
		%UpfrontRewardEditor.create_add_editor(objective.upfront_reward.reward_type)
	if objective.completion_reward:
		%CompletionReward.select(objective.completion_reward.reward_type)
		%CompletionRewardEditor.reward = objective.completion_reward
		%CompletionRewardEditor.create_add_editor(objective.completion_reward.reward_type)
	if objective.trigger:
		%Trigger.select(objective.trigger.trigger_type)
		%TriggerEditor.trigger = objective.trigger
		%TriggerEditor.create_add_editor(objective.trigger.trigger_type)


func _save():
	print("I'd like to save this objective to disk!")
	
 

func _on_objective_name_text_changed() -> void:
	objective.name = objective_name.text


func _on_description_text_changed() -> void:
	objective.description = description.text


func _on_flavor_text_text_changed() -> void:
	objective.flavor_text = flavor_text.text


func _on_rightlink_pressed() -> void:
	rightlink_pressed.emit()


func _on_downlink_pressed() -> void:
	downlink_pressed.emit()


func _on_upfront_reward_selected(index: int) -> void:
	objective.upfront_reward = rewards[index].new()
	%UpfrontRewardEditor.reward = objective.upfront_reward
	%UpfrontRewardEditor.create_add_editor(objective.upfront_reward.reward_type)
