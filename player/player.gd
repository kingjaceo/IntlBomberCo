class_name Player
extends Ship

var game_data: GameData
@export var current_airship: AirshipData
var width: float

signal item_dropped


func _ready():
	power_levels = {'wind': 0, 'lightning': 0	}
	actual_power_levels = power_levels.duplicate()
	health = max_health
	if current_airship:
		Global.player_airship_data = current_airship
	elif Global.player_airship_data:
		current_airship = Global.player_airship_data
	else:
		push_error("No AirshipData detected for player!")
	#position  = current_airship.world_position
	#rotation = current_airship.rotation
	game_data = Global.game_data


func _process(delta):
	target = Global.player_target
	_adjust_actual_power_levels(delta)


func get_blackboard() -> Blackboard:
	return Blackboard.new()


func damage(amount: float):
	health -= amount
	if health <= 0:
		SceneManager.game_over()
