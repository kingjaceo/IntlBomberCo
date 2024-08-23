class_name ContractTab
extends GridContainer

var contracts: Array[Objective]
var contract_panel_scene: PackedScene = load("res://town_screen/contracts/contract_panel.tscn")


func _ready():
	if Global.current_settlement_data:
		contracts = Global.current_settlement_data.contracts
		for child in get_children():
			child.queue_free()
		for contract in contracts:
			var contract_panel = contract_panel_scene.instantiate()
			contract_panel.contract = contract
			add_child(contract_panel)
		
