class_name ContractGenerator
extends Resource

@export var contract_templates: Array[Objective]
var current_index: int = 0


func get_new_contract():
	_check_update_templates()
	if len(contract_templates) > 0:
		var new_contract = contract_templates[current_index].duplicate(true)
		current_index = (current_index + 1) % len(contract_templates)
		return new_contract


func unlock_contract(type: String):
	if type == "destruction":
		var destruction_contract_template = load("res://objectives/destruction_contracts/destroy_in_sabrek.tres")
		contract_templates.append(destruction_contract_template)


func _check_update_templates():
	if Global.player_game_data.reputation.helpfulness >= 2:
		contract_templates[0].trigger.target_amount = 3
		contract_templates[0].completion_reward.reputation.helpfulness = 3	
	if Global.player_game_data.reputation.destructiveness >= 2:
		contract_templates[0].trigger.target_amount = 3
		contract_templates[0].completion_reward.reputation.destructiveness = 3
