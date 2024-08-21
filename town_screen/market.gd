class_name MarketTab
extends GridContainer

var items: Array[GameItem]
var item_panel_scene: PackedScene = load("res://town_screen/items/shop_item_panel.tscn")


func _ready():
	items = Global.current_settlement_data.items
	for child in get_children():
		child.queue_free()
	for item in items:
		var item_panel = item_panel_scene.instantiate()
		item_panel.item = item
		add_child(item_panel)
		
