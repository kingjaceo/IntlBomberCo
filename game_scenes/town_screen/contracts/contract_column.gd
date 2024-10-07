class_name ContractColumn
extends ShopColumn

@export var contract_container: PackedScene


func _ready():
	super._ready()
	_reinstantiate_contracts()
	game_data.contracts_updated.connect(_reinstantiate_contracts)
	


func _reinstantiate_contracts():
	for child in get_tree().get_nodes_in_group("ContractPanel"):
		child.queue_free()
		
	for contract in game_data.contracts:
		var c = contract_container.instantiate()
		c.contract = contract
		add_child(c)
