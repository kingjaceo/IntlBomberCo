extends Range

@export var system: String


func _process(_delta):
	value = owner.actual_power_levels[system] * 10
