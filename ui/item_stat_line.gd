class_name ItemStatLine
extends HBoxContainer

var game_data: GameData
var item_stat: ItemStat
@onready var name_label = %Name
@onready var amount_label = %Amount
@onready var buy_button = %Buy
@onready var cost_label = %Cost


func _ready():
	game_data = Global.game_data
	name_label.text = item_stat.name
	_update_amount()
	_update_buy_button()
	_update_cost()
	item_stat.value_changed.connect(_update_amount)
	buy_button.pressed.connect(_increase)


func _update_amount():
	amount_label.text = "(" + str(item_stat.value) + "/" + str(item_stat.max_value) + ")"


func _update_buy_button():
	buy_button.text = "+ " + str(item_stat.step_size)


func _update_cost():
	cost_label.text = Utility.format_money(item_stat.step_cost)


func _increase():
	if item_stat.value < item_stat.max_value and game_data.money >= item_stat.step_cost:
		item_stat.value += item_stat.step_size
		game_data.money -= item_stat.step_cost
