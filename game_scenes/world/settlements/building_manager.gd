class_name BuildingManager
extends Node2D
# chooses and builds Buildings

var resource_manager: ResourceManager
var build_timer: Timer = Timer.new()
var features: Array[Enums.SettlementFeature]

func _ready():
	await owner.ready
	resource_manager = owner.resource_manager
	features = owner.data.features
	_build()


func _build():
	while true:
		var building_to_build = _choose_building()
		var build_time = 5
		if building_to_build:
			build_time = building_to_build.build_time
		build_timer.start(build_time)
		await build_timer.timeout
		#if building_to_build:
			#building_to_build.build


func _choose_building() -> BuildingData:
	#var all_buildings: Array[Building] = Enums.Buildings
	var best_building: BuildingData
	var highest_utility = 0
	for building in Enums.BuildingType:
		var utility = _building_utility(building)
		if _can_build(building) and _can_afford_now(building) and _can_afford_over_time(building) and utility > highest_utility:
			best_building = building
			highest_utility = utility
	return best_building


func _building_utility(building: BuildingData) -> float:
	var utility = 0
	utility += _production_factor(building) # prefer production
	utility += _population_factor(building) # then population
	return utility


func _can_build(building: BuildingData) -> bool:
	for feature in building.required_features:
		if feature not in features:
			return false
	return true


func _can_afford_now(building: BuildingData) -> bool:
	var resources_on_hand = resource_manager.resources
	var cost_to_build = building.building_cost
	return resources_on_hand.greater_than_or_equal(cost_to_build)


func _can_afford_over_time(building: BuildingData) -> bool:
	var current_production_rate = resource_manager.production_rate
	var consumption_rate = building.consumption_rate
	return current_production_rate.greater_than_or_equal(consumption_rate)


func _production_factor(building: BuildingData) -> float:
	# how much this building will improve current production rate,
	# weighted by the value/rarity of the resources
	var building_production_rate = building.production_rate
	var current_production_rate = resource_manager.production_rate
	current_production_rate.add(building_production_rate)
	var score = current_production_rate.weighted_sum()
	return score


func _population_factor(building: BuildingData) -> float:
	# default preference and scale basis:
	# - "how many new pops can the buliding support?"
	return building.additional_capacity.amount(Enums.ResourceType.POPULATION)


func _get_available_buildings() -> Array[BuildingData]:
	# should probably pass around a list of BuildingData
	# which contain everything we care about for choosing what to build
	var available_buildings = []
	return available_buildings
