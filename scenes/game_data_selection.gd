extends OptionButton

@export var player_game_data: GameData
@export var tutorial_game_data: GameData
@export var debug_game_data: GameData

func _ready():
	_update_game_data(selected)
	item_selected.connect(_update_game_data)


func _update_game_data(item):
	match item:
		0:
			Global.game_data = player_game_data
		1:
			Global.game_data = tutorial_game_data
		2:
			Global.game_data = debug_game_data
