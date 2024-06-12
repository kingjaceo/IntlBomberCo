class_name ShopItemContainer
extends Control

var game_data: GameData
var game_item: GameItem
@export var shop_item_line: PackedScene
@onready var item_name_label = %Name
@onready var item_amount_label = %Amount
@onready var item_buy_button = %Buy
@onready var item_cost_label = %Cost
@onready var item_stat_container = %VBoxContainer



func _ready():
	game_data = Global.game_data
	item_name_label.text = str(game_item.name)
	update()
	item_cost_label.text = Utility.format_money(game_item.cost)
	game_item.amount_changed.connect(update)
	item_buy_button.pressed.connect(increase)

	var first_stat = true
	for item_stat in game_item.item_stats:
		var line = shop_item_line.instantiate()
		line.item_stat = item_stat
		if not has_node("TutorialStep") or not first_stat:
			line.get_node("TutorialStep").free()
		#elif not first_stat and line.has_node("TutorialStep"):
			#line.get_node("TutorialStep").queue_free()
		first_stat = false
		item_stat_container.add_child(line)


func update():
	item_amount_label.text = "(" + str(game_item.amount) + "/" + str(game_item.capacity) + ")"


func increase():
	if game_item.amount < game_item.capacity and game_data.money >= game_item.cost:
		game_data.money -= game_item.cost
		game_item.amount += 1
