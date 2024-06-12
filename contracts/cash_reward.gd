class_name CashReward
extends Reward

@export var amount: float


func receive():
	Global.game_data.money += amount


func _to_string():
	return Utility.format_money(amount)
