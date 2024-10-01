extends Node2D


@export var max_health = 100
var health
@export var chase_radius = 2000
@export var forward_speed: float = 100 # pixels/units per second
@export var rotation_speed: float = 10 # degrees per second
@onready var detection_area: Area2D = %DetectionArea
@export var threat_level: int = 10
@export var max_power_level: int = 3# total amount of combined power
@export var power_levels: Dictionary # {String name : int level}
var actual_power_levels: Dictionary # {String name: float level}
@export var power_gain_rate: float = 0.33 # levels per second
var target: Node2D


func _ready():
	power_levels = {'wind': 0, 'lightning': 0	}
	actual_power_levels = power_levels.duplicate()
	health = max_health


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
		print("I'm dead!")
		queue_free()


func get_blackboard() -> Blackboard:
	return get_node("BehaviorTree").blackboard
