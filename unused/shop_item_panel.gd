class_name ShopItemPanelDEPRECATED
extends Control

var game_data: GameData
var game_item: GameItem
@export var shop_item_line: PackedScene
@onready var item_name_label = %Name
@onready var item_amount_label = %Amount
@onready var item_buy_button = %Buy
@onready var item_cost_label = %Cost
@onready var item_stat_container = %VBoxContainer
@onready var panel_container = %PanelContainer



func _ready():
	game_data = Global.game_data
	game_data.money_changed.connect(_toggle_button)
	_toggle_button()
	
	item_name_label.text = str(game_item.name)
	update()
	item_cost_label.text = Utility.format_money(game_item.cost)
	game_item.amount_changed.connect(update)
	item_buy_button.pressed.connect(increase)
	
	var first_stat = true
	if len(game_item.item_stats) > 0:
		panel_container.visible = true
	
	for item_stat in game_item.item_stats:
		var line = shop_item_line.instantiate()
		line.item_stat = item_stat
		first_stat = false
		item_stat_container.add_child(line)


func update():
	item_amount_label.text = "(" + str(game_item.amount) + "/" + str(game_item.capacity) + ")"


func increase():
	if game_item.amount < game_item.capacity and game_data.money >= game_item.cost:
		game_data.money -= game_item.cost
		game_item.amount += 1


func _toggle_button():
	if game_item.cost > game_data.money:
		item_buy_button.disabled = true
	else:
		item_buy_button.disabled = false
