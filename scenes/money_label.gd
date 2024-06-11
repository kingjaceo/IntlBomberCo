class_name MoneyLabel
extends Label

var game_data: GameData


func _ready():
	game_data = Global.game_data
	game_data.money_changed.connect(_update)
	_update()

func _update():
	text = Utility.format_money(game_data.money)
