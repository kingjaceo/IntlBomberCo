class_name ShopPanel
extends PanelContainer

var game_data: GameData
var game_item: GameItem
@onready var name_label = %Name
@onready var progress_bar = %ProgressBar
@onready var buy_button = %Buy
@onready var cost_label = %Cost


func _ready():
	game_data = Global.game_data
	game_data.money_changed.connect(_toggle_button)
	name_label.text = str(game_item.name)
	cost_label.text = Utility.format_money(game_item.cost)
	game_item.amount_changed.connect(_update_amount)
	buy_button.pressed.connect(_increase)
	_set_progress_bar()
	_update_amount()
	_toggle_button()


func _set_progress_bar():
	progress_bar.max_value = game_item.capacity


func _update_amount():
	progress_bar.value = game_item.amount


func _increase():
	if game_item.amount < game_item.capacity and game_data.money >= game_item.cost:
		game_data.money -= game_item.cost
		game_item.amount += 1
		Events.item_purchased.emit(game_item.item_type)


func _toggle_button():
	if game_item.cost > game_data.money:
		buy_button.disabled = true
	else:
		buy_button.disabled = false
