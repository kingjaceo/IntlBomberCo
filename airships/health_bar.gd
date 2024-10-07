extends ProgressBar


func _process(_delta):
	max_value = owner.max_health
	value = owner.health
