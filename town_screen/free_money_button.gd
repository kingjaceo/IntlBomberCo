extends Button

@export var amount: int = 10000:
	set(value):
		amount = value
		amount_changed.emit()

signal amount_changed


func _ready():
	text = "+ " + Utility.format_money(amount)
	pressed.connect(_add_money)
	amount_changed.connect(_update_amount)


func _add_money():
	Global.game_data.money += amount


func _update_amount():
	text = "+ " + Utility.format_money(amount)
