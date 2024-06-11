class_name ContractPanel
extends PanelContainer

@export var contract: Contract
@onready var amount = %Amount
@onready var reward = %Reward
@onready var button = %Button
@onready var contract_name_label = %ContractName
@onready var description_label = %Description


func _ready():
	contract_name_label.text = contract.name
	description_label.text = contract.description
	amount.text = Utility.format_money(contract.amount)
	reward.text = Utility.format_money(contract.reward)
	button.pressed.connect(_on_accept)

func _on_accept():
	button.text = "Complete"
	contract.accepted = true
	button.pressed.disconnect(_on_accept)
	button.pressed.connect(_on_complete)


func _on_complete():
	print("not implemented!")
