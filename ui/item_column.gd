class_name ItemColumn
extends ShopColumn

@export var shop_item_container: PackedScene

func _ready():
	super._ready()
	for item in game_data.items:
		var c = shop_item_container.instantiate()
		c.game_data = game_data
		c.game_item = item
		add_child(c)
