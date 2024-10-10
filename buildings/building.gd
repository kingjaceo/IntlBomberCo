class_name Building
extends Node2D

@export var building_type: Enums.BuildingType
@onready var sprite_2d: Sprite2D = %Sprite2D

@export var health: float = 100
var destroyed: bool
var settlement: Settlement

@export var building_cost: Resources
@export var produced_resources: Resources
@export var production_cycle_period: float # seconds
var production_timer: Timer = Timer.new()
@export var consumed_resources: Resources
@export var additional_capacity: Resources
@export var consumption_cycle_period: float # seconds
var consumption_timer: Timer = Timer.new()

# TODO: use time_until_cycle_end so that saving/reloading doesn't waste resources
# the building manager connects to this to daisy chain signals
signal building_destroyed
#signal resources_produced(resources)


func _ready():
	add_child(production_timer)
	add_child(consumption_timer)
	settlement = owner
	await settlement.tree_entered
	settlement.increase_resource_capacity(additional_capacity)
	_consumption()
	_production()


func damage(amount: float):
	health -= amount
	if not destroyed and health <= 0:
		destroyed = true
		sprite_2d.set_modulate(Color.BLACK)
		building_destroyed.emit()
		Events.building_destroyed.emit(building_type)


func _consumption():
	while true:
		consumption_timer.start(consumption_cycle_period)
		if settlement.has(consumed_resources):
			settlement.take_resources_from_settlement(consumed_resources)
			production_timer.set_paused(false)
		else:
			_failed_to_consume()
			production_timer.set_paused(true)
		await consumption_timer.timeout


func _production():
	while true:
		production_timer.start(production_cycle_period)
		await production_timer.timeout
		settlement.give_resources_to(produced_resources)


func _failed_to_consume():
	print("I didn't consume what I wanted/needed to! Are there consequences???")
