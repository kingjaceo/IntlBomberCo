class_name Building
extends Node2D

@export var building_data: BuildingData
@export var health: float = 100
var destroyed: bool
var settlement: Settlement
@onready var sprite_2d: Sprite2D = $Sprite2D
var consumption_timer: Timer = Timer.new()
var production_timer: Timer = Timer.new()

# TODO: use time_until_cycle_end so that saving/reloading doesn't waste resources
# the building manager connects to this to daisy chain signals
signal building_destroyed
#signal resources_produced(resources)


func _ready():
	add_child(production_timer)
	add_child(consumption_timer)
	settlement = owner
	await settlement.ready
	settlement.increase_resource_capacity(building_data.additional_capacity)
	settlement.increase_desired_minimum(building_data.desired_minimum)
	if building_data.consumption_cycle_time > 0:
		_consumption()
	if building_data.production_cycle_time > 0:
		_production()


func damage(amount: float):
	health -= amount
	if not destroyed and health <= 0:
		destroyed = true
		sprite_2d.set_modulate(Color.BLACK)
		building_destroyed.emit()
		Events.building_destroyed.emit(building_data.building_type)


func _consumption():
	while true:
		consumption_timer.start(building_data.consumption_cycle_time)
		if settlement.has(building_data.consumed_resources):
			settlement.take_resources_from_settlement(building_data.consumed_resources)
			production_timer.set_paused(false)
		else:
			_failed_to_consume()
			production_timer.set_paused(true)
		await consumption_timer.timeout


func _production():
	while true:
		production_timer.start(building_data.production_cycle_time)
		await production_timer.timeout
		settlement.give_resources_to_settlement(building_data.produced_resources)


func _failed_to_consume():
	print("I didn't consume what I wanted/needed to! Are there consequences???")

func production_rate():
	return building_data.production_rate

func consumption_rate():
	return building_data.consumption_rate
