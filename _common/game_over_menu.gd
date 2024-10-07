class_name GameOverMenu
extends GameMenu


func _ready():
	Events.game_over.connect(_toggle)
