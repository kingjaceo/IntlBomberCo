class_name ContractPanel
extends PanelContainer

@export var contract: Contract
@onready var upfront_reward_label = %Amount
@onready var completion_reward_label = %Reward
@onready var button = %Button
@onready var contract_name_label = %ContractName
@onready var description_label = %Description
@onready var progress_label = %Progress

signal accepted


func _ready():
	contract_name_label.text = contract.name
	description_label.text = contract.description
	if contract.upfront_reward:
		upfront_reward_label.text = str(contract.upfront_reward)
	else:
		upfront_reward_label.text = "None"
	completion_reward_label.text = str(contract.completion_reward)
	button.text = "Accept"
	
	if contract.accepted:
		_show_accepted()
	else:
		button.pressed.connect(_on_accept)
	if contract.completed:
		_enable_complete()

	contract.condition_satisfied.connect(_enable_complete)


func _on_accept():
	_show_accepted()
	contract.activate()
	button.pressed.disconnect(_on_accept)


func _show_accepted():
	button.text = "Complete"
	button.disabled = true
	progress_label.text = contract.progress + "\n\n"
	accepted.emit()


func _enable_complete():
	button.disabled = false
	button.pressed.connect(_on_complete_pressed)
	button.pressed.connect(contract.complete)


func _on_complete_pressed():
	queue_free()
