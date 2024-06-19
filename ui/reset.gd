extends Button


func _ready():
	pressed.connect(get_tree().reload_current_scene)
