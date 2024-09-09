class_name ReputationRewardEditor
extends RewardEditor

var quantity_box: PackedScene = load("res://objectives/objective_grid/objective_editor/quantity_box.tscn")
var reputation_quantities: Dictionary # {ReputationType: QuantityBox}


func _init():
	var reward: Reputation


func _ready():
	if reward:
		for child in get_children():
			child.queue_free()
			
		for reputation_type in Enums.ReputationType:
			_add_quantity_box(reputation_type)


func _add_quantity_box(reputation_type):
	var new_quantity_box: QuantityBox = quantity_box.instantiate()
	new_quantity_box.label_text = reputation_type
	add_child(new_quantity_box)
	if reward:
		new_quantity_box.quantity_changed.connect(_reputation_value_changed.bind(reputation_type))
		new_quantity_box.line_edit.text = str(reward.amounts[reputation_type])


func _reputation_value_changed(amount, reputation_type):
	reward.amounts[reputation_type] = amount
	
