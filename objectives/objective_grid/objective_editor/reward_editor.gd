class_name RewardEditor
extends Control

@export var editor: PackedScene
@export var reward: Reward
var reward_editors: Dictionary = {
	Enums.RewardType.NONE: false,
	Enums.RewardType.REPUTATION: load("res://objectives/objective_grid/objective_editor/reputation_reward_editor.tscn"),
	Enums.RewardType.VICTORY: load("res://objectives/objective_grid/objective_editor/reward_editor.tscn"),
}
var current_editor: RewardEditor


func _ready():
	if editor:
		add_child(editor.instantiate())


func _on_reward_selected(index: int) -> void:
	create_add_editor(index)


func create_add_editor(which: Enums.RewardType):
	if current_editor:
		remove_child(current_editor)
	var new_editor = reward_editors[which]
	if new_editor:
		current_editor = new_editor.instantiate()
		current_editor.reward = reward
		add_child(current_editor)
