class_name RewardEditor
extends Control

@export var editor: PackedScene
@export var reward: Reward
var reward_editors: Dictionary = {
	Enums.RewardType.NONE: false,
	Enums.RewardType.REPUTATION: load("res://objectives/objective_trees/reputation_reward_editor.tscn"),
	Enums.RewardType.VICTORY: load("res://objectives/objective_trees/reward_editor.tscn"),
}
var rewards: Dictionary = {
	Enums.RewardType.NONE: false,
	Enums.RewardType.REPUTATION: ReputationReward.new(),
	Enums.RewardType.VICTORY: Reward.new(),
}
var current_editor: Node


func _ready():
	if editor:
		add_child(editor.instantiate())


func _on_reward_selected(index: int) -> void:
	if current_editor:
		remove_child(current_editor)
	var new_editor = reward_editors[index]
	if new_editor:
		current_editor = new_editor.instantiate()
		current_editor.reward = rewards[index]
		add_child(current_editor)