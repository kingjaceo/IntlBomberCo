class_name ShopItemPanel
extends Control

var game_data: GameData
var item: GameItem
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
	if item:
		_load_item()


func _load_item():
	_toggle_button()
	
	item_name_label.text = str(item.name)
	update()
	item_cost_label.text = Utility.format_money(item.cost)
	item.amount_changed.connect(update)
	item_buy_button.pressed.connect(increase)
	
	var first_stat = true
	if len(item.item_stats) > 0:
		panel_container.visible = true
	
	for item_stat in item.item_stats:
		var line = shop_item_line.instantiate()
		line.item_stat = item_stat
		first_stat = false
		item_stat_container.add_child(line)


func update():
	item_amount_label.text = "(" + str(Global.player_airship_data.try_get_item_amount(item.type)) + "/" + str(item.capacity) + ")"


func increase():
	var player_plane_amount = Global.player_airship_data.try_get_item_amount(item.type)
	if player_plane_amount < item.capacity and game_data.money >= item.cost:
		Global.player_airship_data.add_item(item, 1)
	game_data.money -= item.cost


func _toggle_button():
	if item.cost > game_data.money:
		item_buy_button.disabled = true
	else:
		item_buy_button.disabled = false
