extends Range

@export var system: String


func _process(delta):
	value = owner.power_levels[system] * 10
