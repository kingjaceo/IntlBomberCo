class_name ShopLineItem
extends HBoxContainer

var game_data: GameData
var item_stat: ItemStat
@onready var item_name = %Name
@onready var amount = %Amount
@onready var buy = %Buy
@onready var cost = %Cost


func _ready():
	game_data = Global.game_data
	item_name.text = item_stat.name
	update()
	buy.text = "+" + str(item_stat.step_size)
	cost.text = Utility.format_money(item_stat.step_cost)
	item_stat.value_changed.connect(update)
	buy.pressed.connect(_increment)


func _increment():
	if game_data.money >= item_stat.step_cost:
		game_data.money -= item_stat.step_cost
		item_stat.value += item_stat.step_size


func update():
	amount.text = "(" + str(item_stat.value) + "/" + str(item_stat.max_value) + ")"
