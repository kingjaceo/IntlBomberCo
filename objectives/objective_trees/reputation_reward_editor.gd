class_name ReputationRewardEditor
extends RewardEditor

var quantity_box: PackedScene = load("res://objectives/objective_trees/quantity_box.tscn")


func _ready():
	if reward:
		for child in get_children():
			child.queue_free()
			
		for reputation_type in Enums.ReputationType:
			_add_quantity_box(reputation_type)


func _add_quantity_box(reputation_type):
	var new_quantity_box = quantity_box.instantiate()
	new_quantity_box.label_text = reputation_type
	new_quantity_box.quantity_changed.connect(_reputation_value_changed)
	add_child(new_quantity_box)


func _reputation_value_changed(reputation_type, amount):
	reward.reputation.amounts[reputation_type] = amount
	
