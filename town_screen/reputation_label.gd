class_name ReputationLabel
extends Label

var game_data: GameData


func _ready():
	game_data = Global.game_data
	game_data.reputation_changed.connect(_update)
	_update()

func _update():
	text = str(game_data.reputation)
