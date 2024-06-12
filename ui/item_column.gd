class_name ItemColumn
extends ShopColumn

@export var shop_item_container: PackedScene

func _ready():
	super._ready()
	var first_item = true
	for item in game_data.items:
		var c = shop_item_container.instantiate()
		c.game_item = item
		if not first_item and c.has_node("TutorialStep"):
			c.get_node("TutorialStep").free()
		first_item = false
		add_child(c)
