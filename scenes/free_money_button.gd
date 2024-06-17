extends Button

@export var amount: int = 10000


func _ready():
	pressed.connect(_add_money)

func _add_money():
	Global.game_data.money += amount
