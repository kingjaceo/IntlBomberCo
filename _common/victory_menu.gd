class_name VictoryMenu
extends GameMenu


func _ready():
	Events.victory.connect(_toggle)
