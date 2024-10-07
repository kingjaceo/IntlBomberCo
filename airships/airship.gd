class_name Ship
extends Node2D


@export var max_health = 100
var health

@export var chase_radius = 2000
@export var forward_speed: float = 100 # pixels/units per second
@export var rotation_speed: float = 10 # degrees per second

@export var threat_level: int = 10

@export var max_power_level: int = 3# total amount of combined power
@export var power_levels: Dictionary # {String name : int level}
var actual_power_levels: Dictionary # {String name: float level}
@export var power_gain_rate: float = 0.33 # levels per second

var location: Enums.PlaceName

var hold: Hold

var active_contracts: Array[Objective]
var contract_limit: int = 1 # >= len(objectives)

var target: Node2D
var destination: Node2D


func _ready():
	power_levels = {'wind': 0, 'lightning': 0	}
	actual_power_levels = power_levels.duplicate()
	health = max_health
	if not hold:
		hold = Hold.new()


func _process(delta):
	_adjust_actual_power_levels(delta)


func _adjust_actual_power_levels(delta):
	var power_level_change = power_gain_rate * delta
	for system in power_levels:
		if actual_power_levels[system] < power_levels[system]:
			actual_power_levels[system] += power_level_change
		elif actual_power_levels[system] > power_levels[system]:
			actual_power_levels[system] -= power_level_change


func damage(amount: float):
	health -= amount
	if health <= 0:
		queue_free()


func deliver(resource_type, amount, location):
	# transfer resources to settlement
	pass


func complete(objective: Objective):
	# give self completion reward
	pass


func get_blackboard() -> Blackboard:
	return get_node("BehaviorTree").blackboard


func _dock(area):
	# move body to correct position
	var settlement: Settlement = area.owner.owner
	_complete_contracts(settlement)
	_choose_contracts(settlement)
	_update_destination()
	# undock!


func _complete_contracts(settlement):
	for contract in active_contracts:
		contract.try_complete(self, settlement)


func _choose_contracts(settlement):
	var available_contracts = settlement.get_available_contracts()
	if len(available_contracts) > 0:
		var choice = randi() % len(available_contracts)
		while len(active_contracts) < contract_limit:
			var new_contract = available_contracts[choice]
			activate(new_contract, settlement)
			active_contracts.append(available_contracts[choice])
			choice = (choice + 1) % len(available_contracts)


func _update_destination():
	destination = null
	for contract in active_contracts:
		if contract.trigger.has_method("destination"):
			destination = contract.trigger.destination()
			return


func activate(contract: Objective, settlement: Settlement):
		if contract.trigger is ResourceDeliveredTrigger:
			settlement.request(contract.trigger.target_resource_type, contract.trigger.target_amount, hold)
