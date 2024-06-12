class_name ContractPanel
extends PanelContainer

@export var contract: Contract
@onready var amount = %Amount
@onready var reward = %Reward
@onready var button = %Button
@onready var contract_name_label = %ContractName
@onready var description_label = %Description
@onready var progress_label = %Progress

signal accepted


func _ready():
	contract_name_label.text = contract.name
	description_label.text = contract.description
	amount.text = str(contract.upfront_reward)
	reward.text = str(contract.completion_reward)
	button.text = "Accept"
	
	if contract.accepted:
		_show_accepted()
	else:
		button.pressed.connect(_on_accept)
	if contract.completed:
		button.disabled = false


func _on_accept():
	_show_accepted()
	contract.activate()
	button.pressed.disconnect(_on_accept)


func _show_accepted():
	button.text = "Complete"
	button.disabled = true
	button.pressed.connect(_on_complete)
	progress_label.text = contract.progress + "\n\n"
	accepted.emit()


func _on_complete():
	contract.complete()
	queue_free()
