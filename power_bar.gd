extends ProgressBar

@export var system: String


func _process(delta):
	value = owner.actual_power_levels[system] * 10
