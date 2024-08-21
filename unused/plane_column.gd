class_name PlaneColumn
extends ShopColumn

@export var plane_container: PackedScene

func _ready():
	super._ready()
	_reinstantiate_planes()
	game_data.planes_updated.connect(_reinstantiate_planes)


func _reinstantiate_planes():
	for child in get_tree().get_nodes_in_group("PlanePanel"):
		child.free()
	
	for plane in game_data.planes:
		var c = plane_container.instantiate()
		c.plane = plane
		add_child(c)
