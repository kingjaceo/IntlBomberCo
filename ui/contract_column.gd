class_name ContractColumn
extends ShopColumn

@export var contract_container: PackedScene


func _ready():
	super._ready()
	for contract in game_data.contracts:
		var c = contract_container.instantiate()
		c.contract = contract
		add_child(c)



