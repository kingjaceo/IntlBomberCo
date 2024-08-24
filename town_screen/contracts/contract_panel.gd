class_name ContractPanel
extends PanelContainer

var contract: Objective
@onready var upfront_reward_label = %Amount
@onready var completion_reward_label = %Reward
@onready var button = %Button
@onready var contract_name_label = %ContractName
@onready var description_label = %Description
@onready var progress_label = %Progress

signal accepted


func _ready():
	if contract:
		_load_contract()


func _load_contract():
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
	contract.triggered.connect(_enable_complete)
	contract.progress_changed.connect(_update_progress_label)
	_update_progress_label()


func _on_accept():
	_show_accepted()
	contract.accept()
	Global.player_game_data.add_contract(contract)
	button.pressed.disconnect(_on_accept)


func _show_accepted():
	button.text = "Complete"
	button.disabled = true
	accepted.emit()


func _update_progress_label():
	progress_label.text = contract.progress + "\n\n"


func _enable_complete():
	button.disabled = false
	button.pressed.connect(_on_complete_pressed)
	button.pressed.connect(contract.complete)


func _on_complete_pressed():
	queue_free()
