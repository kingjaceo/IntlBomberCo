class_name PlaneColumn
extends ShopColumn

@export var plane_container: PackedScene

func _ready():
	super._ready()
	for plane in game_data.planes:
		var c = plane_container.instantiate()
		c.plane = plane
		add_child(c)
