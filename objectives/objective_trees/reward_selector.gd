class_name RewardSelector
extends OptionButton

#@export var label_text: String:
	#set(value):
		#label_text = value
		#if label:
			#label.text = label_text
#var reward_editors: Dictionary = {
	#Enums.RewardType.NONE: false,
	#Enums.RewardType.REPUTATION: load("res://objectives/objective_trees/reward_editor.tscn"),
	#Enums.RewardType.VICTORY: load("res://buildings/airdock.tscn"),
#}
#@onready var label: Label = %Label
#@onready var reward: OptionButton = %Reward
#var current_editor: Node
#var reward_panels: Dictionary = {
	#Enums.RewardType.REPUTATION: "reputation panel",
	#Enums.RewardType.VICTORY: "victory panel"
#}

func _ready() -> void:
	#if label_text and label:
		#label.text = label_text
	clear()
	for reward_type in Enums.RewardType:
		add_item(reward_type)#[reward_type])
	#_on_reward_selected(reward.selected)


#func _on_reward_selected(index: int) -> void:
	#if current_editor:
		#remove_child(current_editor)
	#var new_editor = reward_editors[index]
	#if new_editor:
		#current_editor = new_editor.instantiate()
		#add_child(current_editor)
