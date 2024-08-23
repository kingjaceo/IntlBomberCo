extends HBoxContainer

@onready var deliver = %Deliver

func _ready():
	for child in get_children():
		child.item_added.connect(deliver.item_added)
